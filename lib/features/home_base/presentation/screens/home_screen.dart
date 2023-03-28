import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/presentation/services/localization_service.dart';
import 'package:neurocheck/features/tasks/data/repos/task_repo.dart';
import 'package:neurocheck/features/tasks/presentation/screens/boss/completed_boss_tasks_screen.dart';
import '../../../../auth/domain/repos/user_repo.dart';
import '../../../../auth/presentation/screens/add_supervised_screen.dart';
import '../../../tasks/presentation/screens/supervised/add_task_screen.dart';
import '../../../tasks/presentation/screens/boss/add_task_boss_screen.dart';
import '../../../tasks/presentation/screens/boss/show_supervisor_tasks.dart';
import '../../../tasks/presentation/screens/supervised/completed_tasks_screen.dart';
import '../../../tasks/presentation/screens/supervised/show_tasks_screen.dart';

class Index extends StateNotifier<int> {
  Index() : super(1);
  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => Index());

class HomeScreen extends ConsumerWidget {
   const HomeScreen({Key? key}) : super(key: key);
   static bool supervisor = false;

   setSupervisor(bool set){
     supervisor = set;
   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController(initialPage: 1);
    final int menuIndex = ref.watch(indexProvider) as int;

    final String rol = GetStorage().read('rol') ?? '';
    setSupervisor(rol == 'supervisor');

    final List<Widget> pages = supervisor
        ? const [
      AddTaskScreenBoss(),
      ShowSupervisorTasks(),
      CompletedBossTasks(),
    ]
        : const [
      AddTaskScreen(),
      ShowTasks(),
      CompletedTasks(),
    ];

    return Scaffold(
      body: PageView(
          controller: controller,
          children: pages,
          onPageChanged: (i) => ref.read(indexProvider.notifier).value = i
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).iconTheme.color,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add), label: tr(context).add_screen),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: tr(context).show_screen),
            BottomNavigationBarItem(icon: Icon(Icons.library_add_check_outlined),
                label: tr(context).show_done_screen),
          ],
          currentIndex: menuIndex,
          onTap: (i) {
            ref.read(indexProvider.notifier).value = i;
            controller.animateToPage(i,
                duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
          }

          ),
    );
  }

}