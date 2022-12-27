import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/core/routing/app_router.dart';
import 'package:neurocheck/core/styles/app_colors.dart';

import '../../../../core/routing/navigation_service.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/sizes.dart';
import '../../../home/components/card_button_component.dart';
import '../../../home/components/card_user_details_component.dart';
import '../../../notifications/viewmodels/notiControl_provider.dart';
import '../../models/task_model.dart';
import '../../repos/task_repo.dart';
import '../../viewmodels/task_provider.dart';
import '../card_red_button_component.dart';


class CardItemBossComponent extends ConsumerWidget {

  const CardItemBossComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
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
              height: Sizes.vMarginSmall(context),
            ),
            //NOMBRE Y FOTO
            CardUserDetailsComponent(
              taskModel: taskModel,
            ),
            SizedBox(
              height: Sizes.vMarginComment(context),
            ),
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

                  },
                ),

                // borrar supervisor
                CardRedButtonComponent(
                  title: tr(context).delete,
                  isColored: false,
                  onPressed: () {
                    ref.watch(taskProvider.notifier).checkDeleteNoti(taskModel: taskModel);
                  },
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
