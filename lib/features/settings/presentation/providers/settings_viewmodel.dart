import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/features/notifications/presentation/utils/notifications.dart';

import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/routing/route_paths.dart';
import '../../../../core/presentation/providers/main_core_provider.dart';

final settingsViewModel =
    Provider<SettingsViewModel>((ref) => SettingsViewModel(ref));

class SettingsViewModel {
  SettingsViewModel(this.ref) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
  }

  final Ref ref;
  late MainCoreProvider _mainCoreProvider;

  signOut() async {
    cancelScheduledNotifications();

    NavigationService.pushReplacementAll(
      NavigationService.context,
      isNamed: true,
      rootNavigator: true,
      page: RoutePaths.authLogin,
    );
    //Delay until NavigationFadeTransition is done
    await Future.delayed(const Duration(seconds: 1));

    await _mainCoreProvider.logoutUser();


    log('**** signOut cool');
  }

  deleteAccount() async {
    cancelScheduledNotifications();

    NavigationService.pushReplacementAll(
      NavigationService.context,
      isNamed: true,
      rootNavigator: true,
      page: RoutePaths.authLogin,
    );
    //Delay until NavigationFadeTransition is done
    await Future.delayed(const Duration(seconds: 1));

    await _mainCoreProvider.deleteAccount();


    log('**** delete cool');
  }

}
