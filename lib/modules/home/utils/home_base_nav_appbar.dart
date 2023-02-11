import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/utils/dialogs.dart';

import '../../../../core/services/localization_service.dart';
import '../../../core/components/appbar_with_icon_component.dart';
import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/platform_service.dart';
import '../../../core/styles/app_images.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_app_bar_widget.dart';
import '../../../core/widgets/custom_text.dart';
import '../viewmodels/home_base_nav_providers.dart';

/// The default height of the toolbar component of the [AppBar].
const double kToolbarHeight = 56.0;

class PreferredAppBarSize extends Size {
  PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

//todo appbar
class HomeBaseNavAppBar extends ConsumerWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  static bool supervisor = false;

  HomeBaseNavAppBar({
    this.toolbarHeight,
    this.bottom,
    this.backgroundColor,
    this.scaffoldKey,
    Key? key,
  })  : preferredSize =
            PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height),
        super(key: key);

  setSupervisor(bool set) {
    supervisor = set;
  }

  // el app bar que enseñar según donde estés
  @override
  Widget build(BuildContext context, ref) {
    final currentIndex = ref.watch(HomeBaseNavProviders.currentIndex);
    final currentRoute = ref.watch(HomeBaseNavProviders.routes[currentIndex]);

    if (GetStorage().read('rol') != 'supervisor') {
      setSupervisor(false);
    } else {
      setSupervisor(true);
    }
    //log('Home base nav ${supervisor}');

    switch (currentRoute) {

      ///HomeNestedRoutes
      //pantalla principal con menu, nombre app e icono de add sup si se puede
      case RoutePaths.home:
        return CustomAppBar(
          context,
          scaffoldKey: scaffoldKey,
          hasMenuButton:
              PlatformService.instance.isMaterialApp() ? true : false,
          customTitle: CustomText.h2(
            context,
            tr(context).appName,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
          ),
          centerTitle: true,
          trailingActions: [
            //todo añadir icon
            IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  var message =
                      getMessage(GetStorage().read('screen'), context);
                  AppDialogs.showInfo(context, message: message);
                  log('HOMEBASENAV ${GetStorage().read('screen')}');
                  //Navigator.pop(context);
                  //todo: segun pantalla
                },
                icon:  Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                )),
            (supervisor)
                ? IconButton(
                    alignment: Alignment.centerRight,
                    color: Theme.of(context).colorScheme.primary,
                    icon: Icon(PlatformIcons(context).personAdd),
                    onPressed: () {
                      NavigationService.push(
                        context,
                        isNamed: true,
                        page: RoutePaths.addSup,
                      );
                    },
                  )
                : SizedBox(),
          ],
          //IconButton(color: Colors.red, icon: Icon(Icons.add_chart), onPressed: () {  },),
        );

      ///ProfileNestedRoutes
      // apartados de menu lateral
      //perfil
      case RoutePaths.profile:
        return CustomAppBar(
          context,
          hasBackButton:
              PlatformService.instance.isMaterialApp() ? true : false,
          customTitle: CustomText.h2(
            context,

            tr(context).myProfile,
            alignment: Alignment.centerLeft,
          ),
          trailingActions: [
            Container(
              padding: EdgeInsets.only(right: Sizes.vMarginMedium(context)),
              child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    if (GetStorage().read('rol') == 'supervisor') {
                      AppDialogs.showInfo(context,
                          message: tr(context).info_perfil_boss);
                    } else {
                      AppDialogs.showInfo(context,
                          message: tr(context).info_perfil);
                    }
                  },
                  icon:  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).hintColor,
                  )),
            )
          ],
        );

      ///SettingsNestedRoutes
      ///configuracion
      case RoutePaths.settings:
        return CustomAppBar(
          context,
          hasBackButton:
              PlatformService.instance.isMaterialApp() ? true : false,
          customTitle: CustomText.h2(
            context,
            tr(context).settings,
            alignment: Alignment.centerLeft,
          ),
          trailingActions: [
            Container(
              padding: EdgeInsets.only(right: Sizes.vMarginMedium(context)),
              child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    AppDialogs.showInfo(context,
                        message: tr(context).info_config);
                  },
                  icon:  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).hintColor,
                  )),
            )
          ],
          /*AppBarWithIconComponent(
            icon: AppImages.settingsScreenIcon,
            title: tr(context).settings,
          ),*/
        );
      case RoutePaths.settingsLanguage:
        return CustomAppBar(
          context,
          hasBackButton: true,
          customTitle: AppBarWithIconComponent(
            icon: AppImages.languageScreenIcon,
            title: tr(context).language,
          ),
        );

      case RoutePaths.settingsName:
        return CustomAppBar(
          context,
          hasBackButton: true,
          customTitle: AppBarWithIconComponent(
            icon: AppImages.info,
            title: tr(context).change_name,
          ),
        );

      default:
        return const SizedBox();
    }
  }

  @override
  final Size preferredSize;

  @override
  bool shouldFullyObstruct(BuildContext context) {
    final Color backgroundColor =
        CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ??
            CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF;
  }

  String getMessage(String pantalla, BuildContext context) {
    String message = '';

    switch (pantalla) {
      case 'completeBoss':
        message = tr(context).info_completed_boss;
        break;
      case 'add':
        message = tr(context).info_add;
        break;
      case 'showBoss':
        message = tr(context).info_show_boss;
        break;
      case 'show':
        message = tr(context).info_show;
        break;
      case 'complete':
        message = tr(context).info_completed;
        break;
      case 'mod':
        message = tr(context).info_mod;
        break;
    }

    return message;
  }
}
