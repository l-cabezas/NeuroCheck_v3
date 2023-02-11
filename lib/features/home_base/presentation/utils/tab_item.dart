import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:neurocheck/core/routing/app_router.dart';
import 'package:neurocheck/core/routing/route_paths.dart';

import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/sizes.dart';


enum TabItem {
  add(
    initialRoute: RoutePaths.add,
    onGenerateRoute: AppRouter.generateRoute,
  ),
  show(
    initialRoute: RoutePaths.show,
    onGenerateRoute: AppRouter.generateRoute,
  ),
  comp(
    initialRoute: RoutePaths.comp,
    onGenerateRoute: AppRouter.generateRoute,
    noAppBarRoutes: IListConst([RoutePaths.map]),
  );


  const TabItem({
    required this.initialRoute,
    required this.onGenerateRoute,
    this.noAppBarRoutes = const IListConst([]),
  });

  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final IList<String> noAppBarRoutes;
}

extension TabItemExtension on TabItem {
  Widget getTabItemIcon(BuildContext context) {
    switch (this) {
      case TabItem.add:
        return Icon(
          Icons.add,
          size: Sizes.bottomNavBarIconRadius(context),
        );
      case TabItem.show:
        return Icon(
          Icons.home_outlined,
          size: Sizes.bottomNavBarIconRadius(context),
        );
      case TabItem.comp:
        return Icon(
          Icons.done_all,
          size: Sizes.bottomNavBarIconRadius(context),
        );
    }
  }

  Widget getTabItemSelectedIcon(BuildContext context) {
    switch (this) {
      case TabItem.add:
        return Icon(
          Icons.add,
          size: Sizes.bottomNavBarIconRadius(context),
          color: Theme.of(context).colorScheme.primary,
        );
      case TabItem.show:
        return Icon(
          Icons.home_outlined,
          size: Sizes.bottomNavBarIconRadius(context),
          color: Theme.of(context).colorScheme.primary,
        );
      case TabItem.comp:
        return Icon(
          Icons.done_all,
          size: Sizes.bottomNavBarIconRadius(context),
          color: Theme.of(context).colorScheme.primary,
        );
    }
  }

  String getTabItemLabel(BuildContext context) {
    switch (this) {
      case TabItem.add:
        return tr(context).add_screen;
      case TabItem.show:
        return tr(context).show_screen;
      case TabItem.comp:
        return tr(context).done;
    }
  }
}
