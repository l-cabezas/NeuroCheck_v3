import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../firebase_options.dart';
import '../features/theme/presentation/providers/app_theme_provider.dart';
import '../routing/navigation_service.dart';
import '../styles/app_images.dart';
import 'fcm_service/fcm_provider.dart';
import 'local_notfication_service/flutter_local_notifications_provider.dart';

part 'new_services_initializer.g.dart';

@Riverpod(keepAlive: true)
NewServicesInitializer newServicesInitializer(NewServicesInitializerRef ref) {
  return NewServicesInitializer(ref);
}

class NewServicesInitializer {
  NewServicesInitializer(this.ref);

  final NewServicesInitializerRef ref;

  Future<void> init(WidgetsBinding widgetsBinding) async {
    await _initFirebase();
    //This Prevent closing splash screen until we finish initializing our services.
    //App layout will be built but not displayed.
    widgetsBinding.deferFirstFrame();
    widgetsBinding.addPostFrameCallback((_) async {
      //Run any function you want to wait for before showing app layout
      await _initializeServices();
      final BuildContext context = widgetsBinding.renderViewElement!;
      //TODO: check for mounted after flutter v3.4.0 released: https://github.com/flutter/flutter/pull/111619
      //if (!context.mounted) return;
      //await _initializeContextServices(context);
      // Closes splash screen, and show the app layout.
      widgetsBinding.allowFirstFrame();
    });
  }

  _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      await ref.read(setupFlutterLocalNotificationsProvider.future);
      await ref.read(setupFCMProvider.future);
    }
  }

  Future<void> _initializeServices() async {
    await _initLocalization();
    await _initTheme();
    await _initDateFormatting();
  }

  Future<void> _initLocalization() async {
    try {
      //await ref.read(appLocaleControllerProvider.future);
    } catch (_) {}
  }

  Future<void> _initTheme() async {
    try {
      await ref.read(appThemeControllerProvider.future);
    } catch (_) {}
  }

  Future<void> _initDateFormatting() async {
    await initializeDateFormatting();
  }



  Future initializeData() async {
    List futures = [
      _cacheDefaultImages(),
    ];
    List<dynamic> result = await Future.wait<dynamic>([...futures]);
    return result;
  }

  _cacheDefaultImages() async {
    final context = NavigationService.context;
    await precacheImage(   const AssetImage(AppImages.appLogoIcon), context);
  }


}

//This provided handler must be a top-level function.
//It works outside the scope of the app in its own isolate.
//More details: https://firebase.google.com/docs/cloud-messaging/flutter/receive#background_messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  log('Handling a background message ${message.messageId}');
}
