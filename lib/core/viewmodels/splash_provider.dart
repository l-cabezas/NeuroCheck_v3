import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routing/navigation_service.dart';
import '../routing/route_paths.dart';
import '../services/init_services/firebase_messaging_service.dart';
import '../services/init_services/services_initializer.dart';
import 'main_core_provider.dart';


final splashProvider =
Provider.autoDispose<SplashProvider>((ref) => SplashProvider(ref));

class SplashProvider {
  SplashProvider(this.ref) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    init();
  }

  final Ref ref;
  late MainCoreProvider _mainCoreProvider;
  late String secondPage;

  init() async {
    _mainCoreProvider.isConnectedToInternet().then((value) async {
      if (value) {
        initializeData().then(
              (_) {
            NavigationService.pushReplacementAll(
              NavigationService.context,
              isNamed: true,
              page: secondPage,
            );
            if (secondPage == RoutePaths.homeBase) {
              FirebaseMessagingService.instance.getInitialMessage();
            }
          },
        );
      } else {
        NavigationService.pushReplacementAll(
          NavigationService.context,
          isNamed: true,
          page: RoutePaths.coreNoInternet,
          arguments: {'offAll': true},
        );
      }
    });
  }

  Future initializeData() async {
    List futures = [
      Future.delayed(const Duration(milliseconds: 1000)), //Min Time of splash
      ServicesInitializer.instance.initializeServices(),
      ServicesInitializer.instance.initializeData(),
    ];
    await Future.wait<dynamic>([...futures]);
    await checkForCachedUser();
  }

  Future checkForCachedUser() async {
    bool hasValidAuth = await _mainCoreProvider.checkValidAuth();

    if (hasValidAuth) {
      secondPage = RoutePaths.homeBase;
    } else {
      secondPage = RoutePaths.authLogin;
    }
  }
}
