import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/core/routing/app_router.dart';
import 'package:neurocheck/core/styles/app_colors.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../home/components/card_button_component.dart';
import '../../home/components/card_order_details_component.dart';
import '../../home/components/card_user_details_component.dart';
import '../../tasks/components/card_red_button_component.dart';
import '../../tasks/components/time_range_picker.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/repos/task_repo.dart';
import '../screens/supervised/mod_task_screen.dart';
import '../../tasks/viewmodels/task_to_do.dart';

class CardModItemComponent extends ConsumerWidget {

  const CardModItemComponent({
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
          ],
        ),
      ),
    );
  }
}
