import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/screens/popup_page.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../components/verifyEmailFormComponent.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);
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
                //const AppLogoComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                //const WelcomeComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                const VerifyEmailFormComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                CustomButton(
                  text: 'Volver',
                  onPressed: () {
                    NavigationService.push(
                      context,
                      isNamed: true,
                      page: RoutePaths.authLogin,
                    );
                  },
                ),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
              ]),
        ),
      ),
    );
  }
}
