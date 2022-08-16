import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_text_field.dart';

class RegisterTextFieldsSection extends StatelessWidget {
  const RegisterTextFieldsSection({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordController2,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordController2;
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
      CustomTextField(
        context,
        key: const ValueKey('register_name'),
        hintText: tr(context).name,
        controller: nameController,
        validator: Validators.instance.validateName(context),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        suffixIcon: Icon(PlatformIcons(context).accountCircle),
      ),
      CustomTextField(
        context,
        key: const ValueKey('register_email'),
        hintText: tr(context).email,
        controller: emailController,
        validator: Validators.instance.validateEmail(context),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        suffixIcon: Icon(PlatformIcons(context).mail),
      ),

      CustomTextField(
        context,
        key:  const ValueKey('register_password'),
        hintText: tr(context).password,
        controller: passwordController,
        validator: Validators.instance.validateLoginPassword(context),
        textInputAction: TextInputAction.go,
        obscureText: true,
        suffixIcon: const Icon(Icons.password),
        onFieldSubmitted: onFieldSubmitted,
      ),

      CustomTextField(
        context,
        key:  const ValueKey('register_password2'),
        hintText: tr(context).password,
        controller: passwordController2,
        validator: Validators.instance.validateRegisterPassword2(context, passwordController.text, passwordController2.text),
        textInputAction: TextInputAction.go,
        obscureText: true,
        suffixIcon: const Icon(Icons.password),
        onFieldSubmitted: onFieldSubmitted,
      ),

    ];
  }
}
