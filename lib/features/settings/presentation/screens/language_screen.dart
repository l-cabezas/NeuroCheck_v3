import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/routing/route_paths.dart';
import '../../../../core/presentation/screens/popup_page_nested.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/app_colors.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../components/language_item_component.dart';
import '../components/light_button_component.dart';
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
              /*CustomButton(
                text: 'Select',
                onPressed: (){
                    *//*NavigationService.push(
                      context,
                      isNamed: true,
                      page: RoutePaths.settings,
                    );*//*
                  NavigationService.goBack(context);
                },

              )*/
              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
          PlatformWidget(
            material: (_, __) {
              return InkWell(
                onTap: (){NavigationService.goBack(context);},
                child:   LightButtonComponent(
                  icon: Icons.check,
                  text: tr(context).change,
                ),
              );
            },
            cupertino: (_, __) {
              return GestureDetector(
                onTap: (){NavigationService.goBack(context);},
                child:  LightButtonComponent(
                  icon: Icons.check,
                  text: tr(context).change,
                ),
              );
            },
          )
            ],
          ),
        ),
      ),
    );
  }
}

