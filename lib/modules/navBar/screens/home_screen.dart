import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/home/components/upcoming_tasks_component.dart';
import '../../home/viewmodels/noti_providers.dart';
import '../../rol/screens/add_supervised_screen.dart';
import '../../tasks/screens/add_task_screen.dart';
import '../../tasks/screens/completed_tasks_screen.dart';
import '../../tasks/screens/show_tasks_screen.dart';
import '../utils/nav_bar_provider.dart';

class Index extends StateNotifier<int> {
  Index() : super(1);
  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => Index());

class HomeScreen extends ConsumerWidget {
   HomeScreen({Key? key}) : super(key: key);

  final List<Widget> fragments =  [
    AddTaskScreen(),
    ShowTasks(),
    CompletedTasks(),
    //NotiPrueba(),
  ];

  final List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Añadir tarea'),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ver tareas'),
    BottomNavigationBarItem(icon: Icon(Icons.library_add_check_outlined), label: 'Tareas Hechas'),
    //BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Noti'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController(initialPage: 1);
    final int menuIndex = ref.watch(indexProvider) as int;

    return Scaffold(
      body: PageView(
          controller: controller,
          children: fragments,
          onPageChanged: (i) => ref.read(indexProvider.notifier).value = i
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: navItems,
          currentIndex: menuIndex,
          onTap: (i) {
            ref.read(indexProvider.notifier).value = i;
            controller.animateToPage(i,
                duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
          }),
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
