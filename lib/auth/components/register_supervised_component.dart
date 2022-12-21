import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/components/register_supervised_text_fields.dart';

import 'login_text_fields.dart';
import '../viewmodels/auth_provider.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/loading_indicators.dart';

class RegisterSupervisedFormComponent extends HookConsumerWidget {
  const RegisterSupervisedFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final emailControllerSupervised = useTextEditingController(text: '');
    final passwordControllerSupervised = useTextEditingController(text: '');

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          RegisterSupervisedTextFieldsSection(
            emailControllerSupervised: emailControllerSupervised,
            passwordControllerSupervised: passwordControllerSupervised,
            onFieldSubmitted: (value) {
              if (loginFormKey.currentState!.validate()) {
                ref.read(authProvider.notifier).signSupervisedIn(
                  context,
                  emailSupervised: emailControllerSupervised.text,
                  passwordSupervised: passwordControllerSupervised.text,
                );
              }
            },
          ),
          SizedBox(height: Sizes.vMarginSmall(context),),
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
                text: tr(context).addSupervised,
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    ref.watch(authProvider.notifier)
                        .signSupervisedIn(
                      context,
                      emailSupervised: emailControllerSupervised.text,
                      passwordSupervised: passwordControllerSupervised.text,
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