import 'package:flutter/material.dart';

import '../../../core/screens/popup_page_nested.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../components/language_item_component.dart';
import '../utils/language.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPageNested(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
            children: <Widget>[
              CustomText.h3(
                context,
                tr(context).selectYourPreferredLanguage,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Language.values.length,
                itemBuilder: (context, index) {
                  return LanguageItemComponent(
                    language: Language.values[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Sizes.vMarginSmall(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
