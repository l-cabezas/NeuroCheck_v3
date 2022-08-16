import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_themes/cupertino_custom_theme.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/utils/validators.dart';
import '../widgets/titled_text_field_item.dart';


class ProfileTextFieldsSection extends StatelessWidget {
  const ProfileTextFieldsSection({
    required this.nameController,
    //required this.mobileController,
    Key? key,
  }) : super(key: key);

  final TextEditingController nameController;
  //final TextEditingController mobileController;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) {
        return Column(
          children: _sharedItemComponent(context),
        );
      },
      cupertino: (_, __) {
        return Column(
          children: [
            CupertinoFormSection.insetGrouped(
              decoration:
                  CupertinoCustomTheme.cupertinoFormSectionDecoration(context),
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.zero,
              children: _sharedItemComponent(context),
            ),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
          ],
        );
      },
    );
  }

  _sharedItemComponent(BuildContext context) {
    return [
      TitledTextFieldItem(
        title: tr(context).fullName,
        hint: tr(context).enterYourName,
        controller: nameController,
        validator: Validators.instance.validateName(context),
        keyboardType: TextInputType.name,
      ),
      /*TitledTextFieldItem(
        title: tr(context).mobileNumber,
        hint: tr(context).enterYourNumber,
        controller: mobileController,
        validator: Validators.instance.validateMobileNumber(context),
        keyboardType: TextInputType.phone,
        isLastTextField: true,
      ),*/
    ];
  }
}
