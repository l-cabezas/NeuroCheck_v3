import 'package:flutter/material.dart';

import '../../../../core/presentation/routing/app_router.dart';
import '../../../../core/presentation/routing/route_paths.dart';
import '../screens/nested_navigator_screen.dart';

abstract class HomeBaseNavUtils {
  static final navScreensKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'page1'),
    GlobalKey<NavigatorState>(debugLabel: 'page2'),
    GlobalKey<NavigatorState>(debugLabel: 'page3'),
  ];

  static const navScreens = [
    //Nested Navigator for persistent bottom navigation bar
    NestedNavigatorScreen(
      index: 0,
      screenPath: RoutePaths.profile,
      onGenerateRoute: AppRouter.generateProfileNestedRoute,
    ),
    NestedNavigatorScreen(
      index: 1,
      screenPath: RoutePaths.home,
      onGenerateRoute: AppRouter.generateHomeNestedRoute,
    ),
    NestedNavigatorScreen(
      index: 2,
      screenPath: RoutePaths.settings,
      onGenerateRoute: AppRouter.generateSettingsNestedRoute,
    ),
  ];
}
