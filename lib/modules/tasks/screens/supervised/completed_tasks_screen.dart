import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/loading_indicators.dart';
import '../../viewmodels/task_provider.dart';
import '../../viewmodels/task_to_do.dart';
import '../../../navBar/components/card_item_component.dart';

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
                  itemCount: (taskToDo[0].length + taskToDo[1].length),
                  itemBuilder: (context, index) {
                    List<Widget> list = [];
                    var supervised = taskToDo[0].length;
                    var boss = taskToDo[1].length;

                    if (index < supervised) {
                      if(taskToDo[0][index].cancelNoti != 'false'){
                        ref.read(taskProvider.notifier).deleteSingleTask(taskModel: taskToDo[0][index]);
                      }
                      list.add( CardItemComponent(taskModel: taskToDo[0][index],));
                    } else {
                      if (index - supervised < boss) {
                        var indexBoss = index - supervised;
                        if(taskToDo[1][indexBoss].cancelNoti != 'false'){
                          ref.read(taskProvider.notifier).deleteTaskbyBoss(taskModel: taskToDo[1][indexBoss]);
                        }
                        list.add(CardItemComponent(taskModel: taskToDo[1][indexBoss],));
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
