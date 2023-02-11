import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flutter_local_notifications_provider.dart';

part 'show_local_notification_provider.g.dart';

@riverpod
Future<void> showLocalNotification(
  ShowLocalNotificationRef ref,
  ShowLocalNotificationParams params,
) async {
  final notificationService = ref.watch(flutterLocalNotificationsProvider);

  return await notificationService.show(
    0,
    params.title,
    params.body,
    localNotificationDetails,
    payload: params.payload,
  );
}

class ShowLocalNotificationParams {
  final String? title, body, payload;

  const ShowLocalNotificationParams({this.title, this.body, this.payload});
}

const localNotificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'local_push_notification',
    'Deliverzler Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.max,
    priority: Priority.high,
    //color: AppColors.lightThemePrimary,
    playSound: true,
    enableLights: true,
  ),
  iOS: IOSNotificationDetails(
    presentAlert: true,
    presentSound: true,
    presentBadge: true,
  ),
);
