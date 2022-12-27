import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/core/routing/app_router.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/utils/dialogs.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';
import 'package:neurocheck/core/widgets/custom_text_button.dart';
import 'package:neurocheck/modules/tasks/viewmodels/task_provider.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../home/components/card_button_component.dart';
import '../../home/components/card_order_details_component.dart';
import '../../home/components/card_user_details_component.dart';
import '../../notifications/viewmodels/notiControl_provider.dart';
import '../../tasks/components/card_red_button_component.dart';
import '../../tasks/components/time_range_picker.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/repos/task_repo.dart';
import '../../tasks/screens/mod_task_screen.dart';
import '../../tasks/viewmodels/task_to_do.dart';

class CardItemComponent extends ConsumerWidget {

  const CardItemComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    //var taskProvider = ref.watch(tasksRepoProvider);
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadius(context)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.cardVPadding(context),
          horizontal: Sizes.cardHRadius(context),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            //NOMBRE Y FOTO
            CardUserDetailsComponent(
              taskModel: taskModel,
            ),
            SizedBox(
              height: Sizes.vMarginComment(context),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //modificar supervisado
                (taskModel.editable == "true")
                ? CardButtonComponent(
                  title: tr(context).mod,
                  isColored: false,
                  onPressed: () {
                    //IR A PANTALLA DE MODIFICACION DE LA TAREA
                    //TODO
                    NavigationService.push(
                      context,
                      isNamed: true,
                      page: RoutePaths.modScreen,
                      arguments: taskModel
                    );

                  },
                )
                : const SizedBox(),

                (taskModel.editable == "true")
                    ?SizedBox(width: Sizes.hMarginSmall(context),)
                    : SizedBox(),

                //hecho
                (taskModel.done != 'true' && taskModel.editable == 'true')
                  ? CardButtonComponent(
                  title: tr(context).done,
                  isColored: true,
                  onPressed: () {
                    showAlertDialogCheck(context,ref);
                    //ref.watch(taskProvider.notifier).checkTask(context, taskModel: taskModel);
                  //ref.watch(taskProvider.notifier).questionCheck(context, taskModel: taskModel);
                    //ref.watch(taskProvider.notifier).checkTask(taskModel: taskModel);
                    //ref.refresh(tasksRepoProvider);
                  },
                )
                  : SizedBox(),
                //hecho supervisor
                (taskModel.done != 'true' && taskModel.editable == 'false')
                    ? CardButtonComponent(
                  title: tr(context).done,
                  isColored: true,
                  onPressed: () {

                    //DialogWidget.showCustomDialog()
                    showAlertDialogCheck(context,ref);
                  //ref.watch(taskProvider.notifier).checkTask(context,taskModel: taskModel);
                    //ref.watch(taskProvider.notifier).checkTaskBoss(taskModel: taskModel);
                   // ref.watch(taskProvider.notifier).showCheckTestDone(context, taskModel);
                   // ref.refresh(tasksRepoProvider);
                  },
                )
                    : SizedBox(),

                //borrar supervisado
                  (taskModel.editable == 'true' && taskModel.done == 'true')
                      ? CardRedButtonComponent(
                    title: tr(context).delete,
                    isColored: false,
                    onPressed: () {
                      //IR A PANTALLA DE MODIFICACION DE LA TAREA
                      //TODO: borrar tarea
                      //ref.read(taskProvider.notifier).checkDeleteNoti(taskModel: taskModel);
                      showAlertDialogDelete(context,ref);
                      //ref.watch(taskProvider.notifier).deleteSingleTask(taskModel: taskModel);
                     // ref.refresh(tasksRepoProvider);
                    },
                  )
                      : const SizedBox(),
              ],
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),

            //delete
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [(
                //borrar supervisado
                    (taskModel.editable == 'true' && taskModel.done == 'false')
                      ? CardRedButtonComponent(
                        title: tr(context).delete,
                        isColored: false,
                        onPressed: () {
                          //TODO
                          showAlertDialogDelete(context,ref);
                          //ref.watch(notiControlProvider.notifier).deleteNotiControlWT(taskModel: taskModel);
                          //ref.read(taskProvider.notifier).deleteSingleTask(taskModel: taskModel);
                       },
                      )
                      : const SizedBox())
                ]
            )
          ],
        ),
      ),
    );
  }

  showAlertDialogCheck(BuildContext context, ref) {

    // set up the buttons
    Widget okButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).oK,
          color: AppColors.blue
      ),
      onPressed:  () {
        if (taskModel.editable == 'true'){
          ref.watch(taskProvider.notifier).checkTask(context, taskModel: taskModel);
        }else{
          ref.watch(taskProvider.notifier).checkTaskBoss(context, taskModel: taskModel);
        }

        NavigationService.goBack(context,rootNavigator: true);
      },
    );

    Widget cancelButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).cancel,
          color: AppColors.red
      ),
      onPressed:  () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: CustomText.h2(context, tr(context).adv),
      content: CustomText.h3(context,tr(context).adv_done), // todo: tr
      actions: [
        okButton,
        cancelButton,
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogDelete(BuildContext context, ref) {
    // set up the buttons
    Widget okButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).delete,
          color: AppColors.red
      ),
      onPressed:  () {
        ref.read(taskProvider.notifier).checkDeleteNoti(taskModel: taskModel);

        NavigationService.goBack(context,rootNavigator: true);
      },
    );

    Widget cancelButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).cancel,
          color: AppColors.blue
      ),
      onPressed:  () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: CustomText.h2(context, tr(context).adv),
      content: CustomText.h3(context,tr(context).adv_delete), // todo: tr
      actions: [
        okButton,
        cancelButton,
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
