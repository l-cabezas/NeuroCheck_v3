import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:neurocheck/core/widgets/custom_app_bar_widget.dart';

import '../../core/screens/popup_page.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/sizes.dart';
import '../components/register_supervised_component.dart';

class AddSupervisedScreen extends StatelessWidget {
  const AddSupervisedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: AppColors.lightThemePrimary),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: Sizes.appBarDefaultHeight(context),
        actions: [
          IconButton(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              color: AppColors.lightThemePrimary,
              onPressed: (){},
              icon: Icon(
                  PlatformIcons(context).info
              )
          )
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