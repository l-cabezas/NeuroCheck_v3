import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/repos/user_repo.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';
import 'package:neurocheck/modules/tasks/repos/utilities.dart';
import 'package:rxdart/rxdart.dart';
import '../../../auth/models/user_model.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/loading_indicators.dart';
import '../../navBar/components/supervised_card_item_component.dart';
import '../../navBar/viewmodels/task_to_notify_provider.dart';
import '../../simple_notifications/notifications.dart';
import '../viewmodels/task_to_do.dart';
import '../../navBar/components/card_item_component.dart';

class ShowTasks extends HookConsumerWidget {
  const ShowTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _taskRepo = ref.watch(tasksRepoProvider);
    final taskToDoStreamAll = ref.watch(taskMultipleToDoStreamProviderNOTDONE);

    UserModel? user = _taskRepo.returnUsuario();

    return taskToDoStreamAll.when(
        data: (taskToDo) {
      return (taskToDo.isEmpty )
          ? CustomText.h4(
              context,
              tr(context).noTask,
              color: AppColors.grey,
              alignment: Alignment.center,
            )
          : ListView.separated(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.screenVPaddingDefault(context),
              horizontal: Sizes.screenHPaddingMedium(context),
            ),
            separatorBuilder: (context, index) => SizedBox(height: Sizes.vMarginHigh(context),),
            itemCount: taskToDo[0].length + taskToDo[1].length,
            itemBuilder: (context, index) {
              List<Widget> list = [];
              //log('index ${index}');
              var supervised = taskToDo[0].length;
              var boss = taskToDo[1].length;
              if(index < supervised){
                //supervisado
                log('index ${index}');
                list.add(
                    (taskToDo[0][index].taskName == 'tarea0')
                        ? CustomText.h4(
                      context,
                      tr(context).noTask,
                      color: AppColors.grey,
                      alignment: Alignment.center,
                    )
                        : CardItemComponent(
                      taskModel: taskToDo[0][index],
                    )
                );
                //si la notificacion está desactivada y no somos supervisores
                if ((taskToDo[0][index].isNotificationSet == 'false') &&
                    (user?.uidSupervised == '')) {
                  setNotiInSupervised(taskToDo[1][index]);
                }
              }else{
                if(index - supervised < boss){
                  list.add(
                      (taskToDo[1][index - supervised].taskName == 'tarea0')
                          ? CustomText.h4(
                        context,
                        tr(context).noTask,
                        color: AppColors.grey,
                        alignment: Alignment.center,
                      )
                          : CardItemComponent(
                        taskModel: taskToDo[1][index - supervised],
                      )
                  );
                  //si la notificacion está desactivada y no somos supervisores
                  if ((taskToDo[1][index - supervised].isNotificationSet == 'false') &&
                      (user?.uidSupervised == '')) {
                    setNotiInSupervised(taskToDo[1][index - supervised]);
                  }
                }
              }

                return Column(children: list);
              /*(taskToDo[1][index].taskName == 'tarea0')
                    ? CustomText.h4(
                      context,
                      tr(context).noTask,
                      color: AppColors.grey,
                      alignment: Alignment.center,
                    )
                    : CardItemComponent(
                  taskModel: taskToDo[1][index],
                );*/
                //si eres supervisado solo podrás ver las tareas que pones tú

                },

      );
    },
    error: (err, stack) => CustomText.h4(
                            context,
                            tr(context).somethingWentWrong + '\n' + tr(context).pleaseTryAgainLater,
                            color: AppColors.grey,
                            alignment: Alignment.center,
                            textAlign: TextAlign.center,
                            ),
    loading: () => LoadingIndicators.instance.smallLoadingAnimation(context)


    );


    /*return Container(
      color: Colors.blueAccent,
      child:
      ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.screenVPaddingDefault(context),
          horizontal: Sizes.screenHPaddingMedium(context),
        ),
        itemBuilder: (context, index) {
          return CardItemComponent(
              taskModel: TaskModel(editable: 'no', begin: '', end: '', numRepetition: '', done: '', taskName: '', taskId: '')
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: Sizes.vMarginHigh(context),
        ),
        itemCount: 3,
      )
    );*/
  }


}