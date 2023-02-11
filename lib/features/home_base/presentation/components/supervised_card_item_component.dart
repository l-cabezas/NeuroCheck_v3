import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/routing/route_paths.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../home/presentation/components/card_button_component.dart';
import '../../../home/presentation/components/card_user_details_component.dart';
import '../../../tasks/data/models/task_model.dart';
import '../../../tasks/presentation/components/card_red_button_component.dart';

class SupervisedCardItemComponent extends ConsumerWidget {

  const SupervisedCardItemComponent({
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
            CardUserDetailsComponent(
              taskModel: taskModel,
            ),
            SizedBox(
              height: Sizes.vMarginComment(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //boton modificar
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

                  },
                ),

                SizedBox(
                  width: Sizes.vMarginSmallest(context),
                ),

                //boton para borrar
                (taskModel.done == 'true')
                    ? CardRedButtonComponent(
                  title: tr(context).delete,
                  isColored: false,
                  onPressed: () {
                   // ref.watch(notiControlProvider.notifier).checkDelete(taskModel: taskModel);
                  },
                )
                    : const SizedBox()
              ],
            ),


          ],
        ),
      ),
    );
  }
}
