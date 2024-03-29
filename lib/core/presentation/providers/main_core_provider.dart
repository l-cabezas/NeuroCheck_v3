import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/data/repos/auth_repo.dart';
import '../../../auth/domain/repos/user_repo.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/error/failures.dart';
import 'package:geolocator/geolocator.dart';

import '../services/init_services/connectivity_service.dart';
import '../services/location_service/i_location_service.dart';

final mainCoreProvider =
Provider<MainCoreProvider>((ref) => MainCoreProvider(ref));

class MainCoreProvider {
  MainCoreProvider(this.ref) {
    _userRepo = ref.watch(userRepoProvider);
    _authRepo = ref.watch(authRepoProvider);
    _connectivityService = ref.watch(connectivityService);
  }

  final Ref ref;
  late UserRepo _userRepo;
  late AuthRepo _authRepo;
  late ILocationService _locationService;
  late IConnectivityService _connectivityService;

  ///User module methods
  ///comprobamos la validez del usuario que inicia sesión
  Future<bool> checkValidAuth() async {
    final uid = getCurrentUserAuthUid();
    if (uid != null) {
      return await validateAuth(uid);
    } else {
      return false;
    }
  }



  String? getCurrentUserAuthUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  bool? getCurrentStateAccount() {
    return FirebaseAuth.instance.currentUser?.emailVerified;
  }
  Future<bool> isBoss() async {
    final result = await _userRepo.getUserData(getCurrentUserAuthUid()!);
    return result.fold(
          (failure) {
        return false;
      },
          (userModel) {
        if (userModel != null) {
          if(userModel.rol == 'supervisor')
          {return true;}
          else{return false;}
        } else {
          return false;
        }
      },
    );
  }
   checkValidez() async {
     await FirebaseAuth.instance.currentUser!.reload();
  }


  Future<bool> validateAuth(String uid) async {
    final result = await _userRepo.getUserData(uid);
    return result.fold(
          (failure) {
        logoutUser();
        return false;
      },
          (userModel) {
        if (userModel != null) {
          return true;
        } else {
          logoutUser();
          return false;
        }
      },
    );
  }
  // comprobamos si existe ya el usuario si no guardamos los datos
  Future<Either<Failure, bool>> setUserToFirebase(UserModel userModel) async {
    final result = await _userRepo.getUserData(userModel.uId);
    return await result.fold(
          (failure) {
        return Left(failure);
          },
          (userData) async {
        if (userData == null) {
          log('setUserToFirebase');
          return _userRepo.setUserData(userModel);
        } else {
          return const Right(true);
        }
      },
    );
  }

  Future<Either<Failure, bool>> openCollection(UserModel userModel) async {
    //await _userRepo.openCollection(userModel);
    return _userRepo.setUserData(userModel);
  }

  Future<UserModel?> getUserData() async {
    final result = await _userRepo.getUserData(GetStorage().read('uidSup')!);
    return result.fold(
          (failure) {
        return null;
      },
          (userModel) {
        return userModel;
      },
    );
  }


  setSupervisedUid(UserModel userModel) async {
    await _userRepo.setSupervisedUid(userModel);
   GetStorage().write('uidSup',userModel.uidSupervised);
   GetStorage().write('emailSup',userModel.email);

  }

  Future<bool> isBossValid() async {
    return  _authRepo.isVerifiedEmail();
  }

  Future<Either<Failure, bool>> registerUserToFirebase(UserModel userModel) async {
    final result = await _userRepo.registerUserData(userModel);
    return await result.fold(
          (failure) {
        return Left(failure);
      },
          (userData) async {
        if (userData == null) {
           //_userRepo.registerUserData(userModel);
           //return _userRepo.openCollection(userModel);
        } else {
          return const Right(true);
        }
      },
    );
  }

  Future logoutUser() async {
    await _userRepo.clearUserLocalData();
    //await FirebaseMessagingService.instance.unsubscribeFromTopic(topic: 'general');
    await _authRepo.signOut();
    await Future.delayed(const Duration(seconds: 1));

  }

  Future deleteAccount() async {
    await _userRepo.deleteUidBD(GetStorage().read('uidUsuario'));
    await _userRepo.clearUserLocalData();
    //await FirebaseMessagingService.instance.unsubscribeFromTopic(topic: 'general');
    await _authRepo.deleteUser();
    await Future.delayed(const Duration(seconds: 1));
    await _authRepo.signOut();


  }

  ///Location module methods
  Future<bool> enableLocationAndRequestPermission() async {
    bool locationServiceEnabled = await enableLocationService();
    if (locationServiceEnabled) {
      return await requestLocationPermission();
    } else {
      return false;
    }
  }

  Future<bool> enableLocationService() async {
    return await _locationService.enableLocationService();
  }

  Future<bool> requestLocationPermission() async {
    final inUse = await _locationService.requestWhileInUsePermission();
    if (Platform.isAndroid) {
      final always = await _locationService.requestAlwaysPermission();
      return inUse && always;
    } else {
      return inUse;
    }
  }

  Future<bool> isAllLocationPermissionsRequired() async {
    if (Platform.isAndroid) {
      return await _locationService.isLocationServiceEnabled() &&
          await _locationService.isAlwaysPermissionGranted();
    } else {
      return await _locationService.isLocationServiceEnabled() &&
          await _locationService.isWhileInUsePermissionGranted();
    }
  }

  Future<Position?> getCurrentUserLocation() async {
    return await _locationService.getLocation();
  }

  ///Connection module methods
  Future<bool> isConnectedToInternet() async {
    return await _connectivityService.checkIfConnected();
  }
}
