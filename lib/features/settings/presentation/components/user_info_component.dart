import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../auth/domain/repos/user_repo.dart';
import '../../../../core/presentation/styles/app_images.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/cached_network_image_circular.dart';
import '../../../../core/presentation/widgets/custom_text.dart';

class UserInfoComponent extends ConsumerWidget {
  const UserInfoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userRepoProvider).userModel;

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText.h2(
                context,
                userModel!.name!.isEmpty
                    ? 'User${userModel.uId.substring(0, 6)}'
                    : userModel.name!,
                weight: FontStyles.fontWeightBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h4(
                context,
                userModel.email,
                color: Theme.of(context).textTheme.headline5!.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(
          width: Sizes.hMarginDot(context),
        ),
        (userModel.image == '')
            ? CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: Sizes.userImageSmallRadius(context),
          child:  Image.asset(
            AppImages.profileCat,
            fit: BoxFit.cover, ),
        )
            : CachedNetworkImageCircular(
          imageUrl: userModel.image,
          radius: Sizes.userImageSmallRadius(context),
        ),
      ],
    );
  }
}
