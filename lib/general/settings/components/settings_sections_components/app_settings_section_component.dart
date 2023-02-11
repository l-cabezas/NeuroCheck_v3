import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/navigation_service.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/viewmodels/app_locale_provider.dart';
import '../../../../core/viewmodels/app_theme_provider.dart';
import '../../../../core/widgets/custom_tile_component.dart';
import '../settings_section_component.dart';


class AppSettingsSectionComponent extends ConsumerWidget {
  const AppSettingsSectionComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isDarkThemeMode = ref.watch(appThemeProvider) == ThemeMode.dark;
    final _selectedLanguage = ref.watch(appLocaleProvider);

    return SettingsSectionComponent(
      //headerIcon: Icons.settings,
      //headerTitle: tr(context).settings,
      tileList: [
        CustomTileComponent(
          title: tr(context).theme,
          leadingIcon: !isDarkThemeMode ? Icons.wb_sunny : Icons.nights_stay,
          customTrailing: Container(
            constraints: BoxConstraints(
              maxWidth: Sizes.switchThemeButtonWidth(context),
            ),
            child: PlatformSwitch(
              value: !isDarkThemeMode,
              onChanged: (value) {
                ref
                    .watch(appThemeProvider.notifier)
                    .changeTheme(isLight: value);
              },
              material: (_, __) {
                return MaterialSwitchData(
                  activeColor: Theme.of(context).primaryColor,
                  activeTrackColor: Theme.of(context).colorScheme.secondary
                );
              },
              cupertino: (_, __) {
                return CupertinoSwitchData(
                  activeColor: Theme.of(context).colorScheme.secondary
                );
              },
            ),
          ),
        ),
        CustomTileComponent(
          title: tr(context).language,
          leadingIcon: Icons.translate,
          customTrailing:SizedBox(width:43,child:
          Icon(Icons.touch_app_outlined,color: Theme.of(context).colorScheme.secondary)),
          onTap: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsLanguage,
            );
          },
        ),
        CustomTileComponent(
          title: '${tr(context).change_name} ',
          leadingIcon: PlatformIcons(context).edit,
          customTrailing:SizedBox(width:43,child:
          Icon(Icons.touch_app_outlined,
              color: Theme.of(context).colorScheme.secondary)
          ),
          onTap: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsName,
            );
          },
        ),
      ],
    );
  }
}

/*
SizedBox(
height: Sizes.vMarginHigh(context),
),
const ProfileFormComponent(),*/
