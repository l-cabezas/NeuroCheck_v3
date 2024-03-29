import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/features/profile/presentation/components/profile_text_fields_section.dart';

import '../../../../auth/domain/repos/user_repo.dart';
import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/app_colors.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../settings/presentation/components/light_button_component.dart';
import '../providers/profile_provider.dart';

class ProfileFormComponent extends HookConsumerWidget {
  const ProfileFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userRepoProvider).userModel;
    final profileFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController =
        useTextEditingController(text: userModel?.name ?? '');
    //final _mobileController = useTextEditingController(text: _userModel?.phone ?? '');

    return Form(
      key: profileFormKey,
      child: Column(
        children: [
          ProfileTextFieldsSection(
            nameController: nameController,
            //mobileController: _mobileController,
          ),
          SizedBox(
            height: Sizes.vMarginHigh(context),
          ),
          PlatformWidget(
            material: (_, __) {
              return InkWell(
                onTap: (){
                  if (profileFormKey.currentState!.validate()) {
                    ref.watch(profileProvider.notifier).updateProfile(
                      context,
                      name: nameController.text,
                    );
                  }
                  NavigationService.goBack(context);
                  },
                child:   LightButtonComponent(
                  icon: PlatformIcons(context).edit,
                  text: tr(context).change,
                  color: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
                      ? AppColors.lightThemeIconColor
                      : AppColors.darkThemePrimary,
                  textColor: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
                      ? AppColors.lightThemeIconColor
                      : AppColors.darkThemePrimary,
                ),
              );
            },
            cupertino: (_, __) {
              return GestureDetector(
                onTap: (){
                  if (profileFormKey.currentState!.validate()) {
                    ref.watch(profileProvider.notifier).updateProfile(
                      context,
                      name: nameController.text,
                    );
                  }
                  NavigationService.goBack(context);
                },
                child:  LightButtonComponent(
                  icon: Icons.check,
                  text: tr(context).change,
                ),
              );
            },
          )
          /*CustomButton(
            text: tr(context).confirm,
            onPressed: () {
              if (profileFormKey.currentState!.validate()) {
                ref.watch(profileProvider.notifier).updateProfile(
                      context,
                      name: nameController.text,
                      //mobile: _mobileController.text,
                    );
              }
            },
          ),*/
        ],
      ),
    );
  }
}
