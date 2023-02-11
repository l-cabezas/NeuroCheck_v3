
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/platform_widgets/new_platform_nav_bar.dart';
import '../../../../core/styles/font_styles.dart';
import '../../../../core/styles/sizes.dart';
import '../utils/tab_item.dart';


class NewBottomNavBarComponent extends NewPlatformNavBar {
  NewBottomNavBarComponent(
    BuildContext context, {
    Key? key,
    required TabItem currentTab,
    required ValueChanged<TabItem> onSelectTab,
  }) : super(
          key: key,
          currentIndex: currentTab.index,
          onTap: (index) {
            onSelectTab(TabItem.values[index]);
          },
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                  Theme.of(context).bottomAppBarColor,
          height: Sizes.bottomNavBarHeight(context),
          materialData: MaterialBottomNavBarData(
            destinations: TabItem.values
                .map((tabItem) => Theme(
                      data: Theme.of(context).copyWith(
                        navigationBarTheme: NavigationBarThemeData(
                          labelTextStyle:
                              MaterialStateProperty.resolveWith((states) {
                            return TextStyle(
                              fontSize: Sizes.fontSizes(context)["h6"],
                              fontFamily: FontStyles.fontFamily(context),
                            );
                          }),
                        ),
                      ),
                      child: NavigationDestination(
                        icon: tabItem.getTabItemIcon(context),
                        selectedIcon: tabItem.getTabItemSelectedIcon(context),
                        label: tabItem.getTabItemLabel(context),
                      ),
                    ))
                .toList(),
            elevation: 2,
          ),
          cupertinoData: CupertinoTabBarData(
            items: TabItem.values
                .map((tabItem) => BottomNavigationBarItem(
                      icon: tabItem.getTabItemIcon(context),
                      activeIcon: tabItem.getTabItemSelectedIcon(context),
                      label: tabItem.getTabItemLabel(context),
                    ))
                .toList(),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        );
}
