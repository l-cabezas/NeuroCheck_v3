
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';

class RetryAgainComponent extends ConsumerWidget {
  final String description;

  const RetryAgainComponent({
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenHPaddingMedium(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomText.h3(
            context,
            description,
            weight: FontStyles.fontWeightSemiBold,
            alignment: Alignment.center,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Sizes.vMarginMedium(context),
          ),
          CustomButton(
            text: tr(context).retry,
            onPressed:(){},
                //ref.watch(locationServiceProvider.notifier).getCurrentLocation,
            buttonColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
