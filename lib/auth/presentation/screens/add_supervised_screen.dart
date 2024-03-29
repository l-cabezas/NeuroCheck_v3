import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/core/presentation/services/localization_service.dart';
import 'package:neurocheck/core/presentation/widgets/custom_app_bar_widget.dart';
import 'package:neurocheck/core/presentation/widgets/custom_text.dart';

import '../../../core/presentation/screens/popup_page.dart';
import '../../../core/presentation/styles/app_colors.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/utils/dialogs.dart';
import '../components/register_supervised_component.dart';

class AddSupervisedScreen extends StatelessWidget {
  const AddSupervisedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: CustomText(
          context,tr(context).addSupervised,
          color: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
              ? AppColors.lightThemePrimary
              : AppColors.darkThemePrimary,
        ),
        centerTitle: true,
        leading: (GetStorage().read('uidSup') == '')
              ? SizedBox()
              : BackButton(color: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
            ? AppColors.lightThemePrimary
            : AppColors.darkThemePrimary,),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: Sizes.appBarDefaultHeight(context),
        actions: [
          Container( 
            padding: EdgeInsets.only(right: Sizes.vMarginMedium(context)),
            child: IconButton(
              alignment: Alignment.center,
              onPressed: (){
                AppDialogs.showInfo(context,message: tr(context).info_verify);
              },
                icon: Icon(Icons.info_outline,
                  color: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
                      ? AppColors.lightThemePrimary
                      : AppColors.darkThemePrimary,
                )
          ),)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const RegisterSupervisedFormComponent(),
                SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
              ]),
        ),
      ),
    );
  }
}