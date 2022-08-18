import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/loading_indicators.dart';
import '../viewmodels/task_to_do.dart';
import '../../navBar/components/card_item_component.dart';

class ShowTasks extends HookConsumerWidget {
  const ShowTasks({Key? key}) : super(key: key);

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
              return (taskToDo[index].taskName == 'tarea0')
              ? CustomText.h4(
                context,
                tr(context).noTask,
                color: AppColors.grey,
                alignment: Alignment.center,
              )
              : CardItemComponent(
                      taskModel: taskToDo[index],
                  );
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