import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/presentation/components/register_text_fields.dart';
import 'package:neurocheck/auth/presentation/components/see_password.dart';

import '../../../core/presentation/services/localization_service.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/widgets/custom_button.dart';
import '../../../core/presentation/widgets/loading_indicators.dart';
import '../providers/auth_provider.dart';
import '../providers/checkbox_provider.dart';


class RegisterFormComponent extends HookConsumerWidget {
  const RegisterFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final emailController2 = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final passwordController2 = useTextEditingController(text: '');

    final seeValue = ref.watch(seePasswordProvider);
    final seeValue2 = ref.watch(seePasswordProvider2);

    final checkBoxValue = ref.watch(checkBoxProvider);

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          RegisterTextFieldsSection(
            nameController: nameController,
            emailController: emailController,
            emailController2: emailController2,
            passwordController: passwordController,
            passwordController2: passwordController2,
            see: seeValue,
            see2: seeValue2,
            iconButton: IconButton(
              padding: EdgeInsets.only(left: 16, right: 0),
              alignment: Alignment.centerRight,
              icon: Icon(
                  (seeValue) ? PlatformIcons(context).eyeSlashSolid : PlatformIcons(context).eyeSolid
              ),
              onPressed: () {
                ref.watch(seePasswordProvider.notifier)
                    .changeState(change: !seeValue);
              },),
            iconButton2: IconButton(
                padding: EdgeInsets.only(left: 16, right: 0),
                alignment: Alignment.centerRight,
                icon: Icon(
                (seeValue2) ? PlatformIcons(context).eyeSlashSolid : PlatformIcons(context).eyeSolid
            ),
              onPressed: () {
                ref.watch(seePasswordProvider2.notifier)
                    .changeState(change: !seeValue2);
              },),
            onFieldSubmitted: (value) {
              if (loginFormKey.currentState!.validate()) {
                ref.read(authProvider.notifier).createUserWithEmailAndPassword(
                  context,
                  email: emailController.text,
                  password: passwordController.text,
                  name: nameController.text,
                  rol: (checkBoxValue) ? 'supervisor' : 'supervisado'
                );
              }
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          //boton
          Consumer(
            builder: (context, ref, child) {
              final authLoading = ref.watch(
                authProvider.select((state) =>
                    state.maybeWhen(loading: () => true, orElse: () => false)),
              );
              return authLoading
                  ? LoadingIndicators.instance.smallLoadingAnimation(
                context,
                width: Sizes.loadingAnimationButton(context),
                height: Sizes.loadingAnimationButton(context),
              )
                  : CustomButton(
                text: tr(context).register,
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    ref.watch(authProvider.notifier)
                        .createUserWithEmailAndPassword(
                      context,
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      // si sí es supervisor
                      rol: (checkBoxValue) ? 'supervisor' : 'supervisado'
                    );
                  }
                  ref.refresh(seePasswordProvider);
                  //ref.refresh(seePasswordProvider);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}