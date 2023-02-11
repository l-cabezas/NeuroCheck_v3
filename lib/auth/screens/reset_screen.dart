import 'package:flutter/material.dart';
import 'package:neurocheck/auth/components/reset_form_component.dart';

import '../../core/screens/popup_page.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/app_images.dart';
import '../../core/styles/sizes.dart';
import '../../core/utils/dialogs.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      body: SingleChildScrollView(
        child: Column(children:[
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
                  icon: Icon(Icons.arrow_back_outlined, )
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
                  alignment: Alignment.center,
                  onPressed: (){
                    AppDialogs.showInfo(context,message: tr(context).info_reset);
                  },
                  icon: const Icon(Icons.info_outline,)
              ),),
          ],),
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
        )
        ]),
      ),
    );
  }
}
