import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';
import 'package:neurocheck/core/services/init_services/local_notification_service.dart';

import '../../home/components/upcoming_tasks_component.dart';

class NotiPrueba extends HookConsumerWidget {
  const NotiPrueba({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //final taskToDoStream = ref.watch(taskToDoStreamProvider);
    return CupertinoButton(
        child: CustomText.h2(context,'Noti'),
        onPressed: (){
          const UpcomingTasksComponent();
        }
    );
  }

}