import 'dart:developer';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/components/forms/days/switch_theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../../core/presentation/services/localization_service.dart';
import '../../../../../core/presentation/styles/app_colors.dart';
import '../../../../../core/presentation/styles/sizes.dart';
import '../../../../../core/presentation/widgets/custom_text.dart';
import '../../../../../core/presentation/widgets/custom_tile_component.dart';
import 'multi_choice_provider.dart';

class ChooseDaySectionComponent extends ConsumerWidget {
  ChooseDaySectionComponent(this.selectChoices, {Key? key})
      : super(key: key);
  List<String> selectChoices;

  @override
  Widget build(BuildContext context, ref) {
    //final switchValue = ref.watch(switchButtonProviderAdd);
    final multiChoiceValue = ref.watch(selectDaysMultiChoice);

    if (selectChoices.isNotEmpty) {
      //log('switch ' + getDiasString(sortDay(selectChoices)).toString());
      ref.watch(selectDaysMultiChoice.notifier)
         .setChoice(getDiasString(sortDay(selectChoices)));
    }

    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          /*(!switchValue)
            ?*/
          Card(
                  elevation: 6,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Sizes.cardRadius(context)),
                  ),
                  child: ChipsChoice<String>.multiple(
                    value: multiChoiceValue,
                    onChanged: (value) {
                      ref
                          .watch(selectDaysMultiChoice.notifier)
                          .changeChoice(val: value, mix: multiChoiceValue);

                      //con esto pillo los dias
                      //print(ref.read(selectDaysMultiChoice.notifier).tags);
                    },
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: daysList,
                      value: (i, v) => v,
                      label: (i, v) => v,
                    ),
                    wrapped: true,
                    choiceStyle: C2ChoiceStyle(color: Colors.blue),
                  )),
           /*: CustomText.h4(
            context,
            'Se repetirá solamente hoy ',
            color: Theme.of(context).textTheme.headline4!.color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),*/

          SizedBox(
            height: Sizes.vMarginMedium(context),
          ),
        ]));
  }

  static List<String> daysList = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
    "Todos los días"
  ];

  // multiple choice value
  List<String> tags = [];

  List<dynamic> sortDay(List<String> selectedDia) {
    List<dynamic> numbers = [];

    for (var element in selectedDia) {
      numbers.add(mapDays[element]);
    }
    numbers.sort();
    return numbers;
  }

  List<String> getDiasString(List<dynamic> numeros) {
    List<String> tags = [];
    numeros.forEach((element) {
      //print(element.toString());
      if (element < 8) {
        //va de 0..7 no de 1..8
        tags.add(daysList.elementAt(element - 1));
      } else {
        tags.add("Todos los días");
      }
    });
    return tags;
  }

  static Map<String, dynamic> mapDays = {
    "Lunes": 1,
    "Martes": 2,
    "Miércoles": 3,
    "Jueves": 4,
    "Viernes": 5,
    "Sábado": 6,
    "Domingo": 7,
    "Todos los días": 8
    //"Todos los días"
  };
}
