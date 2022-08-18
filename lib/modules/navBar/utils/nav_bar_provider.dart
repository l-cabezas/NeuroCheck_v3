import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../tasks/screens/show_tasks_screen.dart';
import '../../tasks/screens/add_task_screen.dart';
import '../../tasks/screens/completed_tasks_screen.dart';

class Index extends StateNotifier<int> {
  Index() : super(1);
  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => Index());

class NavBar extends ConsumerWidget {
  //static const route = '/home';
   NavBar({Key? key}) : super(key: key);

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