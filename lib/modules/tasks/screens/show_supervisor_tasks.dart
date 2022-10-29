import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/repos/user_repo.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';
import 'package:neurocheck/modules/tasks/repos/utilities.dart';
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

class ShowSupervisorTasks extends HookConsumerWidget {
  const ShowSupervisorTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskToDoStream = ref.watch(taskToDoStreamProvider);

    return taskToDoStream.when(
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
            itemBuilder: (context, index) {
              if(taskToDo[index].taskName != 'tarea0') {
                return (taskToDo[index].taskName == 'tarea0')
                    ? CustomText.h4(
                        context,
                        tr(context).noTask,
                        color: AppColors.grey,
                        alignment: Alignment.center,
                      )
                    : (taskToDo[index].editable != 'false')
                          ? SupervisedCardItemComponent(
                              taskModel: taskToDo[index],
                            )
                      //si eres supervisado solo podrás ver las tareas que pones tú
                          : CustomText.h4(
                                context,
                                tr(context).noTask,
                                color: AppColors.grey,
                                alignment: Alignment.center,
                              );
              }
              return SizedBox();
            },
            separatorBuilder: (context, index) => SizedBox(height: Sizes.vMarginHigh(context),),
            itemCount: taskToDo.length,
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

  }


}