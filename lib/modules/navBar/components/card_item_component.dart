import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/core/routing/app_router.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../home/components/card_button_component.dart';
import '../../home/components/card_order_details_component.dart';
import '../../home/components/card_user_details_component.dart';
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
    var taskProvider = ref.watch(tasksRepoProvider);
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
            //BOTON DE CANCEL -> MODIFICAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardButtonComponent(
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

                    /*NavigationService.push(
                        context,
                        page: ModTaskComponent( taskModel: taskModel,)
                    );*/

                  },
                ),



                // esto era por si estaba llegando -> tarea ya hecha
                /*_isUpcomingOrder
                //hecho
                    ? CardButtonComponent(
                        title: tr(context).deliver,
                        isColored: true,
                        onPressed: () {
                          orderDialogsVM.showDeliverOrderDialog(
                            context,
                            taskModel: taskModel,
                          );
                        },
                      )
                    : CardButtonComponent(
                        title: tr(context).confirm,
                        isColored: true,
                        onPressed: () {
                          orderDialogsVM.showConfirmOrderDialog(
                            context,
                            taskModel: taskModel,
                          );
                        },
                      ),*/
                (taskModel.done != 'true')
                  ? CardButtonComponent(
                  title: tr(context).done,
                  isColored: true,
                  onPressed: () {
                    ref.watch(tasksRepoProvider)
                        .checkTask(taskId: taskModel.taskId);
                    ref.refresh(tasksRepoProvider);
                  },
                )
                  : SizedBox()
              ],
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            CardButtonComponent(
              title: tr(context).delete,
              isColored: false,
              onPressed: () {
                //IR A PANTALLA DE MODIFICACION DE LA TAREA
                //TODO
                ref.watch(tasksRepoProvider)
                        .deleteSingleTask(taskModel: taskModel);
                ref.refresh(tasksRepoProvider);


              },
            ),
          ],
        ),
      ),
    );
  }
}