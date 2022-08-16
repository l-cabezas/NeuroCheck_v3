import 'package:flutter/material.dart';
import 'package:neurocheck/core/styles/app_colors.dart';

import '../../../core/screens/popup_page.dart';
import '../../../core/styles/sizes.dart';

class AddNewModal extends StatelessWidget {
  AddNewModal();

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      body: SingleChildScrollView(
        child: Container(
          constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),

          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingHigh(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('hola'),
                //const AppLogoComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                //const WelcomeComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                //const ResetFormComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
              ]),
        ),
      ),
    );
  }
}
