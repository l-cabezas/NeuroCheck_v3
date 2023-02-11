import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/screens/popup_page_nested.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../modules/profile/components/profile_form_component.dart';

class EditNameScreen extends StatelessWidget {
  const EditNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPageNested(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
            children: <Widget>[
              CustomText.h3(
                context,
                tr(context).name_settings,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),

              const ProfileFormComponent(),

              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
