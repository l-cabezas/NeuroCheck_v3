import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/loading_indicators.dart';
import '../../components/show/card_item_boss_component.dart';
import '../../viewmodels/task_to_do.dart';
import '../../../navBar/components/card_item_component.dart';

class CompletedBossTasks extends HookConsumerWidget {
  const CompletedBossTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskToDoStreamAllCompleted = ref.watch(taskMultipleToDoCompleteStreamProviderBoss);

    //por alguna razon solo funciona si hacemos lista de tareas pero no con un
    // provider individual -> ns pq
    return taskToDoStreamAllCompleted.when(
        data: (taskToDo) {
          return (taskToDo[0].isEmpty )
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
            itemCount: taskToDo[0].length,
            itemBuilder: (context, index) {
              List<Widget> list = [];
              list.add(
                  (taskToDo[0][index].taskName == 'tarea0')
                      ? CustomText.h4(
                    context,
                    tr(context).noTask,
                    color: AppColors.grey,
                    alignment: Alignment.center,
                  )
                      : CardItemBossComponent(
                    taskModel: taskToDo[0][index],
                  )
              );
              return Column(children: list);
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
  }
}
