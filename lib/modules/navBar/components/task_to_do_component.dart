import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/navBar/viewmodels/task_to_do_provider.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/loading_indicators.dart';
import 'card_item_component.dart';

class taskToDoComponent extends ConsumerWidget {
  const taskToDoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final taskToDoStream = ref.watch(taskToDoStreamProvider);
    return taskToDoStream.when(
      data: (toDoTasks) {
        return toDoTasks.isEmpty
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
                  return (toDoTasks[index].taskName != 'tarea0')
                  ?  CardItemComponent(
                    taskModel: toDoTasks[index],
                  )
                  : Card();
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                itemCount: toDoTasks.length,
              );
      },
      error: (err, stack) => CustomText.h4(
        context,
        tr(context).somethingWentWrong + '\n' + tr(context).pleaseTryAgainLater,
        color: AppColors.grey,
        alignment: Alignment.center,
        textAlign: TextAlign.center,
      ),
      loading: () => LoadingIndicators.instance.smallLoadingAnimation(context),
    );
  }
}
