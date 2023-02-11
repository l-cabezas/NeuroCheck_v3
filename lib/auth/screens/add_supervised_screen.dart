import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/core/services/localization_service.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

import '../../core/styles/sizes.dart';
import '../../core/utils/dialogs.dart';
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
          color: Theme.of(context).colorScheme.primary,
        ),
        centerTitle: true,
        leading: (GetStorage().read('uidSup') == '')
              ? SizedBox()
              : BackButton(color: Theme.of(context).colorScheme.primary),
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
              icon:  Icon(Icons.info_outline,
                color: Theme.of(context).colorScheme.secondary)
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