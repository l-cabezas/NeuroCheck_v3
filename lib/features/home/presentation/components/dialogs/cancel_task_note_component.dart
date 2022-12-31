
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../../core/presentation/styles/app_themes/cupertino_custom_theme.dart';
import '../../../../../core/presentation/styles/sizes.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';

class CancelTaskNoteComponent extends StatelessWidget {
  const CancelTaskNoteComponent({
    required this.cancelTaskController,
    Key? key,
  }) : super(key: key);

  final TextEditingController cancelTaskController;

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
              decoration:
              CupertinoCustomTheme.cupertinoFormSectionDecoration(context),
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
        controller: cancelTaskController,
        maxLines: 6,
        maxLength: 200,
        textInputAction: TextInputAction.newline,
        hintText: 'tr(context).typeYourNote + ''...',
        margin: EdgeInsets.only(bottom: Sizes.vMarginSmallest(context)),
      ),
    ];
  }
}
