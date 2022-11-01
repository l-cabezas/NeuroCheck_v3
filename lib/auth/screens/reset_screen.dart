import 'package:flutter/material.dart';
import 'package:neurocheck/auth/components/reset_form_component.dart';

import '../../core/screens/popup_page.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_images.dart';
import '../../core/styles/sizes.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      body: SingleChildScrollView(
        child: Column(children:[
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
          Container(
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
            //vertical: Sizes.screenVPaddingHigh(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                //const AppLogoComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                //const WelcomeComponent(),

                const ResetFormComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
              ]),
        )]),
      ),
    );
  }
}
