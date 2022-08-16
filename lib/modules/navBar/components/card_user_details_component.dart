import 'package:flutter/material.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../tasks/models/task_model.dart';

class CardUserDetailsComponent extends StatelessWidget {
  final TaskModel taskModel;

  const CardUserDetailsComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //FOTO
        /*CachedNetworkImageCircular(
          imageUrl: taskModel.userImage,
          radius: Sizes.userImageSmallRadius(context),
        ),*/
        SizedBox(
          width: Sizes.hMarginSmallest(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NOMBRE -> nombre de la tarea
              CustomText.h5(
                context,
                taskModel.taskName.isEmpty
                    ? 'tr(context).user + taskModel.userId.substring(0, 6)'
                    : taskModel.taskName,
                color: Theme.of(context).textTheme.headline4!.color,
                weight: FontStyles.fontWeightBold,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h6(
                context,
                'taskModel.addressModel!.state '+
                    ', ' +
                    'taskModel.addressModel!.city '+
                    ', ' +
                    'taskModel.addressModel!.street',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h6(
                context,
                'taskModel.addressModel!.mobile',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
