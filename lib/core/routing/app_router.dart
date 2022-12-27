import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:neurocheck/auth/screens/delete_sup_screen.dart';
import 'package:neurocheck/auth/screens/register_screen.dart';
import 'package:neurocheck/auth/screens/reset_screen.dart';
import 'package:neurocheck/auth/screens/verify_email_screen.dart';
import 'package:neurocheck/core/routing/route_paths.dart';
import 'package:neurocheck/auth/screens/add_supervised_screen.dart';
import 'package:neurocheck/general/settings/screens/edit_name_screen.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:neurocheck/modules/tasks/screens/supervised/show_tasks_screen.dart';
import 'package:neurocheck/modules/tasks/screens/supervised/add_task_screen.dart';
import '../../auth/screens/login_screen.dart';
import '../../general/settings/screens/language_screen.dart';
import '../../general/settings/screens/settings_screen.dart';
import '../../modules/home/screens/home_base_screen.dart';
import '../../modules/navBar/screens/home_screen.dart';
import '../../modules/home/utils/home_base_nav_utils.dart';
import '../../modules/tasks/screens/supervised/completed_tasks_screen.dart';
import '../../modules/profile/screens/profile_screen.dart';
import '../../modules/tasks/screens/supervised/mod_task_screen.dart';
import '../screens/no_internet_connection_screen.dart';
import '../screens/splash_screen.dart';
import 'navigation_service.dart';
import 'navigation_transitions.dart';

class AppRouter {
  ///Root Navigator
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      //Core
      //pantalla de carga con el splash screen
      case RoutePaths.coreSplash:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) =>  const SplashScreen(),
          settings: settings,
        );

      //pantalla para cuando no haya internet
      case RoutePaths.coreNoInternet:
        final args = settings.arguments as Map?;
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => NoInternetConnection(
            offAll: args?['offAll'],
          ),
          settings: settings,
        );

      //Auth
    //pantalla de login
      case RoutePaths.authLogin:
        return NavigationSlideFromSide(
          const LoginScreen(),
          settings: settings,
         transitionDuration: const Duration(microseconds: 700),
        );

      case RoutePaths.authRegister:
        return NavigationSlideFromSide(
          const RegisterScreen(),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      case RoutePaths.verifyEmail:
        return NavigationSlideFromSide(
           VerifyEmailScreen(),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      case RoutePaths.addSup:
        return NavigationSlideFromSide(
          const AddSupervisedScreen(),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      case RoutePaths.deleteSup:
        return NavigationSlideFromSide(
          const DeleteSupScreen(),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      case RoutePaths.authReset:
        return NavigationSlideFromSide(
          const ResetScreen(),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      //HomeBase
    //pantalla inicial
      case RoutePaths.homeBase:
        return NavigationFadeTransition(
          const HomeBaseScreen(),
          settings: settings,
        );

    //todo
      case RoutePaths.modScreen:
        final args = settings.arguments as TaskModel?;
        return NavigationFadeTransition(
          ModTaskComponent(taskModel: args!,),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      case RoutePaths.map:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) =>  HomeScreen(),
          settings: settings,
        );

        //por default estamos en la pantalla de carga
      default:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }

  ///Nested Navigators
  static Route<dynamic> generateHomeNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Home
      case RoutePaths.home:
        return NavigationFadeTransition(
           HomeScreen(),
          settings: settings,
        );

      case RoutePaths.modScreen:
        final args = settings.arguments as TaskModel?;
        return NavigationFadeTransition(
          ModTaskComponent(taskModel: args!,),
          settings: settings,
          transitionDuration: const Duration(microseconds: 700),
        );

      default:
        return NavigationFadeTransition(
           HomeScreen(),
          settings: settings,
        );
    }
  }

  static Route<dynamic> generateProfileNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Profile
      case RoutePaths.profile:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[0].currentContext!,
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[0].currentContext!,
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
    }
  }

  static Route<dynamic> generateSettingsNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Settings
      case RoutePaths.settings:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      case RoutePaths.settingsLanguage:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
          builder: (_) => const LanguageScreen(),
          settings: settings,
        );
      case RoutePaths.settingsName:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
          builder: (_) => const EditNameScreen(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );
    }
  }


}
