import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        //await submitLogin(context, userModel);
      },
    );
  }

  createUserWithEmailAndPassword(
      BuildContext context, {
        required String email,
        required String password,
        required name,
      }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final result = await _authRepo.createUserWithEmailAndPassword(
      context,
      email: email,
      password: password,
      name: name
    );
    await result.fold(
          (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
          (user) async {
        UserModel userModel = user;
        await submitLogin(context, userModel);
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
  openCollection(UserModel userModel) async {
    await _mainCoreProvider.openCollection(userModel);
  }

  Future submitLogin(BuildContext context, UserModel userModel) async {
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
          navigationToHomeScreen(context);
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
      page: RoutePaths.homeBase,
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