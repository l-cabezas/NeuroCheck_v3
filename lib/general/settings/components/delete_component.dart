import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../viewmodels/settings_viewmodel.dart';

class DeleteComponent extends ConsumerWidget {
  const DeleteComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settingsVM = ref.watch(settingsViewModel);

    return PlatformWidget(
      material: (_, __) {
        return InkWell(
          onTap: () async {
            showAlertDialogDelete(context,settingsVM);
            //await settingsVM.deleteAccount();
          },
          child: const _SharedItemComponent(),
        );
      },
      cupertino: (_, __) {
        return GestureDetector(
          onTap: () async {
            showAlertDialogDelete(context,settingsVM);
            //await settingsVM.deleteAccount();

          },
          child: const _SharedItemComponent(),
        );
      },
    );
  }

  showAlertDialogDelete(BuildContext context, SettingsViewModel settingsVM) {
// todo: tr
    // set up the buttons
    Widget okButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).delete,
          color: AppColors.blue
      ),
      onPressed:  () async {
        await settingsVM.deleteAccount();
      },
    );

    Widget cancelButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).cancel,
          color: AppColors.red
      ),
      onPressed:  () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: CustomText.h2(context, tr(context).adv),
      content: CustomText.h3(context,tr(context).delete_acc),
      actions: [
        cancelButton,
        okButton,

      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


class _SharedItemComponent extends StatelessWidget {
  const _SharedItemComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.vPaddingSmall(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(
          Sizes.dialogSmallRadius(context),
        ),
        border: Border.all(
          width: 1,
          color: AppColors.lightThemePrimary,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.delete,
            color: AppColors.lightThemePrimary,
          ),
          SizedBox(
            width: Sizes.hMarginSmall(context),
          ),
          CustomText.h4(
            context,
            'Borrar Cuenta', //todo: tr
            alignment: Alignment.center,
            weight: FontStyles.fontWeightExtraBold,
            color: AppColors.lightThemePrimary,
          ),
        ],
      ),
    );
  }
}