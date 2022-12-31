import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/presentation/widgets/custom_text.dart';
import 'package:neurocheck/features/home_base/presentation/components/card_item_component.dart';
import 'package:neurocheck/features/tasks/presentation/providers/time_range_picker_provider.dart';

import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_tile_component.dart';

class TimePickerComponent extends ConsumerWidget {
  TimePickerComponent(this.horas, {Key? key}) : super(key: key);
  String horas = '';
 // bool oneTime;
  @override
  Widget build(BuildContext context, ref) {
    final timePicker = ref.watch(timeRangeButtonProvider.notifier);
   // timePicker.setOneTime(oneTime);
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
      CustomText.h4(
        context,
        tr(context).choose_range,
        color: Theme.of(context).textTheme.headline4!.color,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      ),
      SizedBox(
        height: Sizes.vMarginMedium(context),
      ),
      GestureDetector(
          onTap: () {
            timePicker.showPicker(context);
            //log(timePicker.state);
          },
          child: Container(
              height: 50,
              width: 200,
              child: Card(
                  elevation: 6,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Sizes.cardRadius(context)),
                  ),
                  child: Center(
                    child: (timePicker.getHours() == '00:00 - 00:00')
                                ? CustomText.h3(context, horas)
                                : CustomText.h3(context, timePicker.getHours()),
                  )))),
    ]));
  }
}
