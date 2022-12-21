import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/screens/popup_page_nested.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../modules/profile/components/profile_form_component.dart';
import '../components/light_button_component.dart';
import '../components/settings_sections_components/app_settings_section_component.dart';
import '../components/user_info_component.dart';

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
                'Cambiar nombre usuario', // todo: tr
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
