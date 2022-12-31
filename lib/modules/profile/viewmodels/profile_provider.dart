import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/modules/profile/viewmodels/profile_state.dart';

import '../../../auth/domain/repos/user_repo.dart';
import '../../../core/data/local/image_selector.dart';
import '../../../core/presentation/utils/dialogs.dart';

final profileProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref) : super(const ProfileState.available()) {
    _userRepo = ref.read(userRepoProvider);
  }

  final Ref ref;
  late UserRepo _userRepo;

  Future updateProfile(
    BuildContext context, {
    required String name,
    //required String mobile,
  }) async {
    state = const ProfileState.loading();
    final result = await _userRepo.updateUserData(
      _userRepo.userModel!.copyWith(
        name: name,
        //phone: mobile,
      ),
    );
    await result.fold(
      (failure) {
        AppDialogs.showErrorDialog(context, message: failure.message);
        state = ProfileState.error(errorText: failure.message);
      },
      (isSet) async {
        if (isSet) {
          state = const ProfileState.available();
        }
      },
    );
  }

  Future updateProfileImage(
    BuildContext context, {
    required bool fromCamera,
  }) async {
    final result = await ImageSelector.instance.pickImage(
      context,
      fromCamera: fromCamera,
    );
    result.fold(
      (failure) {
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
      (pickedFile) {
        if (pickedFile != null) {
          updateFirebaseImage(context, pickedFile);
        }
      },
    );
  }

  updateFirebaseImage(BuildContext context, File? image) async {
    state = const ProfileState.loading();
    final result = await _userRepo.updateUserImage(image);
    await result.fold(
      (failure) {
        AppDialogs.showErrorDialog(context, message: failure.message);
        state = ProfileState.error(errorText: failure.message);
      },
      (isSet) async {
        if (isSet) {
          state = const ProfileState.available();
        }
      },
    );
  }
}
