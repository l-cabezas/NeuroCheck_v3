import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterSupervisedTextFieldsSection extends StatelessWidget {
  const RegisterSupervisedTextFieldsSection({
    required this.emailController,
    required this.passwordController,
    required this.emailControllerSupervised,
    required this.passwordControllerSupervised,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final TextEditingController emailControllerSupervised;
  final TextEditingController passwordControllerSupervised;

  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) {
        return Column(
          children: _sharedItemComponent(context),
        );
      },
      cupertino: (_, __) {
        return Column(
          children: [
            CupertinoFormSection.insetGrouped(
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.zero,
              children: _sharedItemComponent(context),
            ),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
          ],
        );
      },
    );
  }

  _sharedItemComponent(BuildContext context) {
    return [
      CustomText.h3(context, tr(context).askYourDates),
      SizedBox(height: Sizes.textFieldVMarginDefault(context)),
      CustomTextField(
        context,
        key: const ValueKey('login_email'),
        hintText: tr(context).email,
        controller: emailController,
        validator: Validators.instance.validateEmail(context),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        suffixIcon: Icon(PlatformIcons(context).mail),
      ),

      CustomTextField(
        context,
        key:  const ValueKey('login_password'),
        hintText: tr(context).password,
        controller: passwordController,
        validator: Validators.instance.validateLoginPassword(context),
        textInputAction: TextInputAction.go,
        obscureText: true,
        suffixIcon: const Icon(Icons.password),
        onFieldSubmitted: onFieldSubmitted,
      ),

      SizedBox(height: Sizes.textFieldVMarginDefault(context)),

      CustomText.h3(context, tr(context).askDates),

      SizedBox(height: Sizes.textFieldVMarginDefault(context)),

      CustomTextField(
        context,
        key: const ValueKey('login_emailS'),
        hintText: tr(context).email,
        controller: emailControllerSupervised,
        validator: Validators.instance.validateEmail(context),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        suffixIcon: Icon(PlatformIcons(context).mail),
      ),

      CustomTextField(
        context,
        key:  const ValueKey('login_passwordS'),
        hintText: tr(context).password,
        controller: passwordControllerSupervised,
        validator: Validators.instance.validateLoginPassword(context),
        textInputAction: TextInputAction.go,
        obscureText: true,
        suffixIcon: const Icon(Icons.password),
        onFieldSubmitted: onFieldSubmitted,
      ),

    ];

  }

}
