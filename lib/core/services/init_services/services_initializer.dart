import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:deliverzler/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/services/init_services/storage_service.dart';

import '../../../firebase_options.dart';
import '../../routing/navigation_service.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_images.dart';
import '../../viewmodels/app_theme_provider.dart';
import '../theme_service.dart';
import 'awesome_notification.dart';
import 'connectivity_service.dart';
import 'firebase_messaging_service.dart';
import 'local_notification_service.dart';
import 'package:neurocheck/firebase_options.dart';


class ServicesInitializer {
  ServicesInitializer._();

  static final ServicesInitializer instance = ServicesInitializer._();

  late ProviderContainer container;

  init(WidgetsBinding widgetsBinding, ProviderContainer container) async {
    this.container = container;
    //Init FirebaseApp instance before runApp
    await _initFirebase();
    //_iniNoti();
    //This Prevent closing splash screen until we finish initializing our services.
    //App layout will be built but not displayed.
    widgetsBinding.deferFirstFrame();
    widgetsBinding.addPostFrameCallback((_) async {
      //Run any function you want to wait for before showing app layout
      //await _initializeServices(); init services at custom splash
      _initializeServicesRef();
      BuildContext? context = widgetsBinding.renderViewElement;
      if (context != null) {
        await _initializeCustomSplashImages(context);
      }
      // Closes splash screen, and show the app layout.
      widgetsBinding.allowFirstFrame();
    });

  }

  _iniNoti(){
    AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: AppColors.blue,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: '',
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: AppColors.blue,
          locked: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/res_custom_notification',
          channelDescription: '',
        ),
      ],
    );
  }

  _initializeServicesRef() {
    ThemeService(container.read);
  }

  _initializeCustomSplashImages(BuildContext context) async {
    await precacheImage(const AssetImage(AppImages.appLogoIcon), context);
  }

  initializeServices() async {
    await _initStorageService();
    await _initTheme();
    await _initFirebase();
    await _initConnectivity();
    //await _initNotificationSettings();
    //await _initFirebaseMessaging();
  }

  _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initFirebaseMessaging();
  }

  _initStorageService() async {
    await container.read(storageService).init();
  }


  _initTheme() async {
    await container.read(appThemeProvider.notifier).init();
  }

  _initConnectivity() async {
    container.read(connectivityService).init();
  }

  _initNotificationSettings() async {
    await LocalNotificationService(container).init();
  }


  _initFirebaseMessaging() async {
    await FirebaseMessagingService.instance.init();
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
    await precacheImage( const AssetImage(AppImages.appLogoIcon), context);
  }
}
