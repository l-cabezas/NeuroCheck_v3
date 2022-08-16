import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/services/localization_service.dart';
import '../../tasks/models/task_model.dart';

class CardOrderDetailsComponent extends StatelessWidget {
  final TaskModel taskModel;

  const CardOrderDetailsComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: LocalizationService.instance.isGl(context)
              ? CrossAxisAlignment.baseline
              : CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            //ORDER ONTHE WAY O YA UPCOMING
            /*Container(
              height: Sizes.statusCircleRadius(context),
              width: Sizes.statusCircleRadius(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: taskModel.orderDeliveryStatus ==
                        describeEnum(OrderDeliveryStatus.upcoming)
                    ? Colors.green
                    : Colors.blue,
              ),
            ),
            SizedBox(
              width: Sizes.hMarginTiny(context),
            ),
            Expanded(
              child: CustomText.h6(
                context,
                taskModel.orderDeliveryStatus ==
                        describeEnum(OrderDeliveryStatus.upcoming)
                    ? tr(context).orderUpcoming
                    : tr(context).orderOnTheWay,
                weight: FontStyles.fontWeightExtraBold,
                color: taskModel.orderDeliveryStatus ==
                        describeEnum(OrderDeliveryStatus.upcoming)
                    ? Colors.green
                    : Colors.blue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),*/
        //FECHA DE ARRIBA DE LA IZQUIERDA
        /*CustomText.h6(
          context,
          DateParser.instance.convertEpochToLocal(context, taskModel.date),
          overflow: TextOverflow.ellipsis,
        ),*/
      ],
    )
    ]);
  }
}
