import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:neurocheck/auth/components/register_form_component.dart';

import '../../core/screens/popup_page.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_images.dart';
import '../../core/styles/sizes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      body: SingleChildScrollView(
        child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Sizes.hMarginExtreme(context),
                      bottom: Sizes.vMarginSmallest(context),
                      left: Sizes.vMarginSmall(context),
                    ),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_outlined, color: AppColors.lightBlue,)
                    ),),
                  SizedBox(width: Sizes.fullScreenWidth(context)/1.6,),
                  Container(
                    padding: EdgeInsets.only(
                      top: Sizes.hMarginExtreme(context),
                      bottom: Sizes.vMarginSmallest(context),
                      left: Sizes.vMarginSmall(context),
                    ),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: (){
                          //Navigator.pop(context);
                        },
                        icon: const Icon(Icons.info_outline, color: AppColors.lightBlue,)
                    ),),
                ],),
                //const AppLogoComponent(),
                Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                //fondo
                decoration: const BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(
                      AppImages.loginBackground,
                      ),
                      fit: BoxFit.fill,
                      ),
                ),
                padding: EdgeInsets.symmetric(
                //vertical: Sizes.screenVPaddingHigh(context),
                horizontal: Sizes.screenHPaddingDefault(context),
                ),
                //const WelcomeComponent(),
                child: Column(
                      children: [
                                SizedBox(
                          height: Sizes.vMarginHigh(context),
                        ),

                        const RegisterFormComponent(),

                        SizedBox(
                          height: Sizes.vMarginHigh(context),
                        ),]
                ),
        ),
      ]),
    )
    );
  }
}
