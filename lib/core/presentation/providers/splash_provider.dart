import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/core/presentation/utils/dialogs.dart';

import '../routing/navigation_service.dart';
import '../routing/route_paths.dart';
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
                log('**** CRON FALSE');
                GetStorage().write('CronSet','false');
                GetStorage().write('reset','false');
            NavigationService.pushReplacementAll(
              NavigationService.context,
              isNamed: true,
              page: secondPage,
            );
            if (secondPage == RoutePaths.homeBase) {
              //FirebaseMessagingService.instance.getInitialMessage();
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
    bool? hasVerify =  _mainCoreProvider.getCurrentStateAccount();

//    log('hasValidAuth $hasValidAuth');
    if (hasValidAuth) {
      //cancelamos los cron hechos para volver a ponerlos

      //si el email ha sido verificado si es supervisor

      bool isBoss = await _mainCoreProvider.isBoss();
//      log('isBoss $isBoss');
//      log('hasVerify $hasVerify');
      //es supervisor
      if(isBoss){
        if(hasVerify!) {
          secondPage = RoutePaths.homeBase;
        }else{
          secondPage = RoutePaths.verifyEmail;
        }
      }else{
        log('**** RESET CRON');
        Cron().close();
        GetStorage().write('false','CronSet');

        //no es supervisor
        secondPage = RoutePaths.homeBase;
      }

    } else {
      //recheck notification
      secondPage = RoutePaths.authLogin;
    }
  }
}
