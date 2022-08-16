import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/home/components/upcoming_tasks_component.dart';
import '../../home/viewmodels/noti_providers.dart';
import '../utils/nav_bar_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(notificationTaskProvider.notifier);
    return Scaffold(
      body: const UpcomingTasksComponent(),
        bottomNavigationBar: NavBar()
    );
  }

}

/*  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  //iconos
  List<Widget> buildBottomNavBarItems() {
    return <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
           // Icon(Icons.call_split, size: 30),
          //  Icon(Icons.perm_identity, size: 30),
          ];
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: [
        GreenSectionComponent(),//Green(),
        Blue(),
        Red(),

      ],
    );
  }*/

/*  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }*/

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      */ /*bottomNavigationBar: CurvedNavigationBar(
        index: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),*/ /*
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Discovery'),
            TabItem(icon: Icons.add, title: 'Add'),
            TabItem(icon: Icons.message, title: 'Message'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          onTap: (int i) => print('click index=$i'),
        )
    );
  }
  }
*/
