import 'package:flutter/material.dart';

import '../../../core/presentation/routing/navigation_service.dart';
import '../../../core/presentation/routing/route_paths.dart';
import '../../../core/presentation/screens/popup_page.dart';
import '../../../core/presentation/services/localization_service.dart';
import '../../../core/presentation/styles/app_images.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/widgets/custom_button.dart';
import '../components/app_logo_component.dart';
import '../components/login_form_component.dart';
import '../components/welcome_component.dart';

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
              const AppLogoComponent(),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              //const WelcomeComponent(),
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
                buttonColor: Theme.of(context).primaryColor,
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
