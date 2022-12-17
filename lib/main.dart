

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/repos/user_repo.dart';
import 'core/routing/app_router.dart';
import 'core/routing/navigation_service.dart';
import 'core/routing/route_paths.dart';
import 'core/services/init_services/services_initializer.dart';
import 'core/services/theme_service.dart';
import 'core/styles/app_colors.dart';
import 'core/styles/app_themes/dark_theme.dart';
import 'core/styles/app_themes/light_theme.dart';
import 'core/viewmodels/app_locale_provider.dart';
import 'core/viewmodels/app_theme_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'l10n/l10n.dart';
import 'modules/tasks/repos/task_repo.dart';

void main() async {
  //This let us access providers before runApp (read only)
  final container = ProviderContainer();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await ServicesInitializer.instance.init(widgetsBinding, container);

  /*final cron = Cron();
  cron.schedule(Schedule.parse('12 13 * * *'), () async {
    log("This code runs at 12am everyday");
    //update task to no hecho
    // ref.watch(tasksRepoProvider);

  });*/

  AwesomeNotifications().initialize(
    null,
    //'resource://drawable/res_notification_app_icon',
    [
      /*NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: AppColors.blue,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',
      ),*/
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelGroupKey: 'scheduled_channel_group',
        defaultColor: AppColors.blue,
        playSound:true,
        locked: true,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_notification',
        channelDescription: '',
      ),
    ],
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  /*////Notification Listener

  AwesomeNotifications()
      .actionStream
      .listen((ReceivedNotification receivedNotification) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
          (Route<dynamic> route) => false,
    );
  });*/
  runApp(
    //All Flutter applications using Riverpod
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final platformBrightness = usePlatformBrightness();
    final appLocale = ref.watch(appLocaleProvider);
    final appTheme = ref.watch(appThemeProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Theme(
        data: ThemeService.instance.isDarkMode(appTheme, platformBrightness)
            ? DarkTheme.darkTheme
            : LightTheme.lightTheme,
        //esto nos sirve para tener cosas distintas según la plataforma
        child: PlatformApp(

          navigatorKey: NavigationService.navigationKey,
          debugShowCheckedModeBanner: false,
          title: 'NeuroCheck',
          color: AppColors.lightThemePrimary,

          locale: appLocale,
          supportedLocales: L10n.all,
          localizationsDelegates: L10n.localizationsDelegates,


          initialRoute: RoutePaths.coreSplash,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
