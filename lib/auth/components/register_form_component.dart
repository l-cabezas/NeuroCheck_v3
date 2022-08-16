import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/components/register_text_fields.dart';

import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/loading_indicators.dart';
import '../viewmodels/auth_provider.dart';


class RegisterFormComponent extends HookConsumerWidget {
  const RegisterFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final passwordController2 = useTextEditingController(text: '');

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          RegisterTextFieldsSection(
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
            passwordController2: passwordController2,
            onFieldSubmitted: (value) {
              if (loginFormKey.currentState!.validate()) {
                ref.read(authProvider.notifier).createUserWithEmailAndPassword(
                  context,
                  email: emailController.text,
                  password: passwordController.text,
                  name: nameController.text
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
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}