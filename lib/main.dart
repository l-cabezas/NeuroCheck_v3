

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/core_features/presentation/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core_features/presentation/providers/current_app_theme_provider.dart';
import 'core/core_features/presentation/providers/provider_observer.dart';
import 'core/data/local/local_storage_caller/shared_pref_local_storage_caller.dart';
import 'core/presentation/providers/app_locale_provider.dart';
import 'core/presentation/providers/app_theme_provider.dart';
import 'core/presentation/routing/app_router.dart';
import 'core/presentation/routing/navigation_service.dart';
import 'core/presentation/routing/route_paths.dart';
import 'core/presentation/services/init_services/services_initializer.dart';
import 'core/presentation/services/theme_service.dart';
import 'core/presentation/styles/app_colors.dart';
import 'core/presentation/styles/app_themes/dark_theme.dart';
import 'core/presentation/styles/app_themes/light_theme.dart';
import 'l10n/l10n.dart';

void main() async {
  //This let us access providers before runApp (read only)
  //final container = ProviderContainer();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  //This let us access providers before runApp
  final ProviderContainer container = ProviderContainer(
    overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
    observers: [LogProviderObserver()],
  );

  await ServicesInitializer.instance.init(widgetsBinding, container);
  await GetStorage.init();

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
      // todo: sacar aviso
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

    useOnPlatformBrightnessChange((previous, current) {
      ref.read(platformBrightnessProvider.notifier).state = current;
    });

    final appLocale = ref.watch(appLocaleProvider);
    final theme = ref.watch(currentAppThemeProvider);

    //final appTheme = ref.watch(appThemeProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Theme(
        data: theme.getThemeData(),
        //esto nos sirve para tener cosas distintas según la plataforma
        child: PlatformApp(

          navigatorKey: NavigationService.navigationKey,
          debugShowCheckedModeBanner: false,
          //title: 'NeuroCheck',
          color: Theme.of(context).colorScheme.primary,
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
