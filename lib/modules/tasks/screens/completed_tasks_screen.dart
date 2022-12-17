import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/loading_indicators.dart';
import '../viewmodels/task_to_do.dart';
import '../../navBar/components/card_item_component.dart';

class CompletedTasks extends HookConsumerWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskToDoStreamAll = ref.watch(taskMultipleToDoStreamProviderDONE);
    return taskToDoStreamAll.when(
        data: (taskToDo) {
          log('CompletedTasks length ${taskToDo[0].length} y boss ${taskToDo[1].length}');
          return (taskToDo.isEmpty || (taskToDo[0].length == 0 && taskToDo[1].length == 0))
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
                  separatorBuilder: (context, index) => SizedBox(
                    height: Sizes.vMarginHigh(context),
                  ),
                  itemCount: taskToDo[0].length + taskToDo[1].length,
                  itemBuilder: (context, index) {
                    List<Widget> list = [];
                    var supervised = taskToDo[0].length;
                    var boss = taskToDo[1].length;
                    if (index < supervised) {
                      //supervisado
                      log('index ${index}');
                      list.add((taskToDo[0][index].taskName == 'tarea0')
                          ? SizedBox()
                      /*CustomText.h4(
                              context,
                              tr(context).noTask,
                              color: AppColors.grey,
                              alignment: Alignment.center,
                            )*/
                          : CardItemComponent(
                              taskModel: taskToDo[0][index],
                            ));
                    } else {
                      if (index - supervised < boss) {
                        list.add((taskToDo[1][index - supervised].taskName ==
                                'tarea0')
                            ? SizedBox()
                        /*CustomText.h4(
                                context,
                                tr(context).noTask,
                                color: AppColors.grey,
                                alignment: Alignment.center,
                              )*/
                            : CardItemComponent(
                                taskModel: taskToDo[1][index - supervised],
                              ));
                      }
                    }

                    return Column(children: list);
                  },
                );
        },
        error: (err, stack) => CustomText.h4(
              context,
              tr(context).somethingWentWrong +
                  '\n' +
                  tr(context).pleaseTryAgainLater,
              color: AppColors.grey,
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ),
        loading: () =>
            LoadingIndicators.instance.smallLoadingAnimation(context));
  }
}
