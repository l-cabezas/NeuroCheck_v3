import 'package:flutter/material.dart';

import '../../../core/screens/popup_page_nested.dart';
import '../../../core/styles/sizes.dart';
import '../components/logout_component.dart';
import '../components/settings_sections_components/app_settings_section_component.dart';
import '../components/user_info_component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              const UserInfoComponent(),
              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),
              const AppSettingsSectionComponent(),
              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
              const LogoutComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
