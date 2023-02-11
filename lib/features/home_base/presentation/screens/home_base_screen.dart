import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/screens/popup_page.dart';
import 'package:neurocheck/features/home_base/presentation/screens/tab_navigator_screen.dart';

import '../../../../core/components/main_drawer.dart';
import '../../../../core/presentation/widgets/platform_widgets/new_platform_tab_scaffold.dart';
import '../../../../core/routing/navigation_service.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../modules/home/utils/home_base_nav_appbar.dart';
import '../../../../modules/home/utils/home_base_nav_utils.dart';
import '../../../../modules/home/viewmodels/home_base_nav_providers.dart';
import '../../../notifications/domain/entities/app_notification.dart';
import '../../../notifications/presentation/providers/fcm_remote_message_providers.dart';
import '../../../notifications/presentation/providers/tapped_notification_provider.dart';
import '../components/new_bottom_nav_bar_component.dart';
import '../components/tab_appbar_component.dart';
import '../providers/tabs_providers.dart';
import '../utils/tab_item.dart';

class HomeBaseScreen extends HookConsumerWidget {
  const HomeBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final selectedTab = ref.watch(selectedTabProvider);
    final navigatorKeys = useMemoized(() => {
          TabItem.add: GlobalKey<NavigatorState>(debugLabel: 'page1'),
          TabItem.show: GlobalKey<NavigatorState>(debugLabel: 'page2'),
          TabItem.comp: GlobalKey<NavigatorState>(debugLabel: 'page3'),
        });

    useEffect(() {
      ref.read(getInitialMessageProvider);
      ref.listenManual(onMessageProvider, (previous, next) {});
      ref.listenManual(onMessageOpenedAppProvider, (previous, next) {});
      return null;
    }, []);

    //TODO [Enhancement]: use go_router for better deep links handling
    ref.listen<Option<AppNotification>>(
      tappedNotificationProvider,
      (previous, next) {
        if (next is Some<AppNotification>) {
          final notification = next.value;
          ref.read(selectedTabProvider.notifier).state = TabItem.values
              .firstWhere(
                  (tab) => tab.initialRoute == notification.initialRoute);
          if (notification.route != null) {
            NavigationService.push(
              navigatorKeys[selectedTab]!.currentContext!,
              isNamed: true,
              page: notification.route,
            );
          }
        }
      },
    );

    for (final provider in HomeBaseNavProviders.routes) {
      ref.watch(provider.notifier);
    }
    final _currentIndex = ref.watch(HomeBaseNavProviders.currentIndex);
    final _indexNotifier = ref.watch(HomeBaseNavProviders.currentIndex.notifier);
    final _scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());

    return PopUpPage(
      safeAreaNavBar: true,
      onWillPop: () async {

        //This prevent popping the main navigator when pressing mobile's back button
        if (await HomeBaseNavUtils.navScreensKeys[_currentIndex].currentState!
            .maybePop()) {
          return false;
        }
        //This prevent popping when index isn't 1 (Home) & instead will back to home
        if (_currentIndex != 1) {
          _indexNotifier.state = 1;
          return false;
        }
        //This prevent popping the main navigator when pressing mobile's back button
        final selectedNavKey = navigatorKeys[selectedTab];
        if (await selectedNavKey!.currentState!.maybePop()) {
          return false;
        }
        //This prevent popping when tab isn't (Home) & instead will back to home
        if (selectedTab != TabItem.show) {
          ref.read(selectedTabProvider.notifier).state = TabItem.show;
          return false;
        }
        return true;
      },
      consumerAppBar: HomeBaseNavAppBar(
        toolbarHeight: Sizes.appBarDefaultHeight(context),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        scaffoldKey: _scaffoldKey,
        ),
      /*drawer: MainDrawer(
        scaffoldKey: _scaffoldKey,
      ),*/
      body:  NewPlatformTabScaffold(
          materialData: NewMaterialTabScaffoldData(
            //Using single persistent AppBar for all tabs and update it with state management. This is necessary to avoid using
            //nested scaffolds as it's not recommended by Flutter. While for iOS we can use CupertinoTabScaffold which has
            //tabBuilder/tabBar(BNB) and each nested screen can use CupertinoPageScaffold that can have individual Appbar.
            drawer: MainDrawer(
              scaffoldKey: _scaffoldKey,
            ),
            body: HomeBaseMaterialBody(navigatorKeys: navigatorKeys),
          ),
          cupertinoData: NewCupertinoTabScaffoldData(
            cupertinoTabBuilder: (context, index) {
              final tab = TabItem.values[index];
              //Using Navigator for both android and iOS (instead of CupertinoTabView which does the same)
              return TabNavigatorScreen(
                tabItem: tab,
                navigatorKey: navigatorKeys[tab]!,
              );
            },
          ),
          bottomNavigationBar: NewBottomNavBarComponent(
            context,
            currentTab: selectedTab,
            onSelectTab: (tab) {
              ref.read(selectedTabProvider.notifier).state = tab;
            },
          ),
        ),
    );
  }
}

class HomeBaseMaterialBody extends HookConsumerWidget {
  const HomeBaseMaterialBody({
    required this.navigatorKeys,
    Key? key,
  }) : super(key: key);

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context, ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    final pageController = usePageController(initialPage: selectedTab.index);

    ref.listen<TabItem>(
      selectedTabProvider,
      (previous, next) {
        pageController.jumpToPage(next.index);
      },
    );

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: TabItem.values
          .map((tab) => TabNavigatorScreen(
                tabItem: tab,
                navigatorKey: navigatorKeys[tab]!,
              ))
          .toList(),
    );
  }
}
