import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/screens/popup_page_nested.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../profile/presentation/components/profile_form_component.dart';
import '../components/light_button_component.dart';

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
