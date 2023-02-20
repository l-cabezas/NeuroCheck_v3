import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/presentation/providers/app_locale_provider.dart';
import '../../../../../core/presentation/providers/app_theme_provider.dart';
import '../../../../../core/presentation/routing/navigation_service.dart';
import '../../../../../core/presentation/routing/route_paths.dart';
import '../../../../../core/presentation/services/localization_service.dart';
import '../../../../../core/presentation/styles/app_colors.dart';
import '../../../../../core/presentation/styles/sizes.dart';
import '../../../../../core/presentation/widgets/custom_tile_component.dart';
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
                  activeColor: AppColors.white,
                  activeTrackColor: AppColors.blue,
                  inactiveTrackColor: AppColors.darkThemePrimary,
                  inactiveThumbColor: AppColors.white
                );
              },
              cupertino: (_, __) {
                return CupertinoSwitchData(
                  activeColor: AppColors.blue,
                );
              },
            ),
          ),
        ),
        CustomTileComponent(
          title: tr(context).language,
          leadingIcon: Icons.translate,
          customTrailing:SizedBox(width:43,child:
          Icon(Icons.touch_app_outlined,
            color: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
                ? AppColors.blue
                : AppColors.darkThemePrimary,
          )
          ),
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
          customTrailing:SizedBox(
              width:43,
              child:
              Icon(Icons.touch_app_outlined,
                color: Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
                    ? AppColors.blue
                    : AppColors.darkThemePrimary,
              )),
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
