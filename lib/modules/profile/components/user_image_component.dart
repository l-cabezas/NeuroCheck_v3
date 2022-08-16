
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/repos/user_repo.dart';
import '../../../core/components/image_pick_component.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/cached_network_image_circular.dart';
import '../viewmodels/profile_provider.dart';

class UserImageComponent extends ConsumerWidget {
  const UserImageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userRepoProvider).userModel!;
    final profileVM = ref.watch(profileProvider.notifier);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CachedNetworkImageCircular(
          imageUrl: userModel.image,
          radius: Sizes.userImageHighRadius(context),
        ),
        Padding(
          padding: EdgeInsets.only(right: Sizes.hPaddingTiny(context)),
          child: ImagePickComponent(
            pickFromCameraFunction: () {
              profileVM.updateProfileImage(context, fromCamera: true);
            },
            pickFromGalleryFunction: () {
              profileVM.updateProfileImage(context, fromCamera: false);
            },
          ),
        ),
      ],
    );
  }
}
