import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/services/init_services/firebase_messaging_service.dart';
import '../../core/services/localization_service.dart';
import '../../core/utils/dialogs.dart';
import '../../core/viewmodels/main_core_provider.dart';
import '../models/user_model.dart';
import '../repos/auth_repo.dart';
import 'auth_state.dart';

final authProvider =
StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref) : super(const AuthState.available()) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    _authRepo = ref.watch(authRepoProvider);
  }


  final Ref ref;
  late MainCoreProvider _mainCoreProvider;
  late AuthRepo _authRepo;

  signInWithEmailAndPassword(
      BuildContext context, {
        required String email,
        required String password,
      }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final result = await _authRepo.signInWithEmailAndPassword(
      context,
      email: email,
      password: password,
    );
    await result.fold(
          (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
          (user) async {
        UserModel userModel = user;

        var prefs = await _mainCoreProvider.setPreferences();
        /*log('ROL ${user.name}');
        prefs.setString('rol', user.rol ?? 'no');
        prefs.setString('prueba', 'prueba');
        final myString = prefs.getString('rol') ?? '';
        log('SHARED PREFERENCES ${prefs.getString('rol')}');
        log('SHARED PREFERENCES PRUEBA ${prefs.getString('prueba')}');*/

        subscribeUserToTopic();
        navigationToHomeScreen(context);
        //await submitLogin(context, userModel);
      },
    );
  }

  signSupervisedIn(
      BuildContext context, {
        required String email,
        required String password,
        required String emailSupervised,
        required String passwordSupervised,
      }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final result = await _authRepo.signSupervisedIn(
      context,
      email: email,
      password: password,
      emailSupervised: emailSupervised,
      passwordSupervised: passwordSupervised
    );
    await result.fold(
          (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
          (user) async {
        UserModel userModel = user;
        log('userSupervisedPreAuth ${userModel.name}');
        log('userSupervisedPreAuth ${userModel.uidSupervised}');
        _mainCoreProvider.setSupervisedUid(userModel);
        subscribeUserToTopic();
        NavigationService.pushReplacementAll(
          NavigationService.context,
          isNamed: true,
          page: RoutePaths.coreSplash,
          arguments: {'offAll': true},
        );
        //navigationToHomeScreen(context);
        //await submitLogin(context, userModel);
      },
    );
  }

  createUserWithEmailAndPassword(
      BuildContext context, {
        required String email,
        required String password,
        required String name,
        required String rol
      }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final result = await _authRepo.createUserWithEmailAndPassword(
      context,
      email: email,
      password: password,
      name: name,
      rol: rol
    );
    await result.fold(
          (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
          (user) async {
        UserModel userModel = user;
        await submitRegister(context, userModel);
      },
    );
  }

  sendPasswordResetEmail(
      BuildContext context, {
        required String email,
      }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final result = await _authRepo.sendPasswordResetEmail(
      context,
      email: email,
    );
    result.fold(
          (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
        },
        (done){
          AppDialogs.showErrorDialog(context, message: tr(context).reset);
          navigationToLogin(context);
        }

    );

  }

  sendEmailVerification(BuildContext context) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final result = await _authRepo.sendEmailVerification(
      context,
    );
    result.fold(
            (failure) {
          state = AuthState.error(errorText: failure.message);
          AppDialogs.showErrorDialog(context, message: failure.message);
        },
            (done){
              //state = AuthState.available();
              navigationToCheckScreen(context);
        }
    );
  }

  openCollection(UserModel userModel) async {
    await _mainCoreProvider.openCollection(userModel);
  }

  Future submitRegister(BuildContext context, UserModel userModel) async {
    log(userModel.toMap().toString());
    final result = await _mainCoreProvider.setUserToFirebase(userModel);
    await result.fold(
          (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
        (isSet) async {
          openCollection(userModel);
          subscribeUserToTopic();
          //que solo se lo pida al supervisor
          if((userModel.rol != 'supervisor')) {
          await _authRepo.sendEmailVerification(context);
        }
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('rol', userModel.rol!);
          final myString = prefs.getString('my_string_key') ?? '';
        log('SHARED PREFERENCES ${myString}');
        (userModel.rol != 'supervisor')
          ? navigationToHomeScreen(context)
          : navigationToCheckScreen(context);
      },
    );
  }

  subscribeUserToTopic() {
    FirebaseMessagingService.instance.subscribeToTopic(
      topic: 'general',
    );
  }

  navigationToHomeScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.home,
    );
  }

  navigationToCheckScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.verifyEmail,
    );
  }

  navigationToLogin(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.authLogin,
    );
  }
}
