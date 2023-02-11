import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core_features/presentation/providers/current_app_theme_provider.dart';
import '../helpers/theme_helper.dart';

class FullScreenPlatformScaffold extends ConsumerWidget {
  const FullScreenPlatformScaffold({
    required this.body,
    this.darkOverlays,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final bool? darkOverlays;

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(currentAppThemeProvider);

    return PlatformScaffold(
      hasEmptyAppbar: false,
      body: AnnotatedRegion(
        value: getFullScreenOverlayStyle(
          context,
          darkOverlays: darkOverlays ?? currentTheme == AppTheme.light,
        ),
        child: body,
      ),
    );
  }
}
