import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification_service.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();

  static final instance = FirebaseMessagingService._();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'firebase_push_notification',
    'NeuroCheck Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  Future init() async {
    //On iOS, macOS & web, before FCM payloads can be received on your device
    //you must first ask the user's permission.
    //Android applications are not required to request permission.
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    // Create an Android Notification Channel.
    // We use this channel in the `AndroidManifest.xml` file to override the
    // default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Update the iOS foreground notification presentation options to allow
    // heads up notifications on Apple devices.
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      sound: true,
      badge: false,
    );

    // Called when FCM payload is received while the app is in the foreground.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //In the foreground will not display a visible notification by default, on both Android & iOS.
      //It is however possible to override this behavior by using FlutterLocalNotificationsPlugin.
      //Also you can handle pressing a notification on foreground with onSelectNotification & payload.
      _showNotification(message);
      _callsWhenReceiveNotification(message);
    });

    // Called when a user presses a notification message displayed via FCM.
    // Only if the app has opened from background state (not foreground or terminated).
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _callsWhenReceiveNotification(message);
      final messageData = message.data;
      LocalNotificationService.instance.onSelectNotification(
        jsonEncode(messageData),
      );
    });

    //Set a message handler function which is called when the app is in the background or terminated.
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  _showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    final messageData = message.data;
    if (notification != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        _notificationDetails(),
        payload: jsonEncode(messageData),
      );
    }
  }

  _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: channel.importance,
        priority: Priority.high,
        //color: AppColors.lightThemePrimary,
        playSound: true,
      ),
      iOS: const IOSNotificationDetails(),
    );
  }

  _callsWhenReceiveNotification(RemoteMessage message) async {
    //Do something
  }

  getInitialMessage() {
    // Called when the application open from a terminated state.
    // If it opened via notification, RemoteMessage will be returned, otherwise it will be null.
    // Should be called in app initState or at home screen because we need context for navigation.
    firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        final messageData = message.data;
        LocalNotificationService.instance.onSelectNotification(
          jsonEncode(messageData),
        );
      }
    });
  }

  getDeviceFCMToken() async {
    return await firebaseMessaging.getToken();
  }

  deleteDeviceFCMToken() async {
    await firebaseMessaging.deleteToken();
  }

  subscribeToTopic({required String topic}) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  unsubscribeFromTopic({required String topic}) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

//This provided handler must be a top-level function.
//It works outside the scope of the app in its own isolate.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.messageId}');
}
