import 'package:flutter/material.dart';

import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/screens/popup_page.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/app_images.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../components/login_form_component.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.loginBackground,
              ),
              fit: BoxFit.fill,
            ),
          ),
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
              const LoginFormComponent(),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
               CustomButton(
                    text: tr(context).register,
                    onPressed: () {
                      NavigationService.push(
                        context,
                        isNamed: true,
                        page: RoutePaths.authRegister,
                      );
                    },
                  ),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              CustomButton(
                text: tr(context).reset,
                onPressed: () {
                  NavigationService.push(
                    context,
                    isNamed: true,
                    page: RoutePaths.authReset,
                  );
                },
              ),
              ]),
          ),
        ),
      );
  }
}