

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/custom_outlined_button.dart';
import '../../home/components/card_button_component.dart';

class MultiSelectWeek extends StatefulWidget {
  //List<dynamic> select;
 TextEditingController daysSelect;
  MultiSelectWeek(this.daysSelect);

  @override
  _MultiSelectWeekState createState() => _MultiSelectWeekState();
}

class _MultiSelectWeekState extends State<MultiSelectWeek> {

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




  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Card(child:  ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(() {
                        tags = val;

                        if(tags.contains("Todos los días")){
                          if(val.last != "Todos los días"){
                            val.remove("Todos los días");
                            tags = val;

                          } else{
                            tags = ["Todos los días"];
                            widget.daysSelect.text= getDiasString(sortDay(tags)).toString();
                          }

                        }
                        //print('dasdas '+getDiasString(sortDay(tags)).toString());
                      }),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: daysList,
                        value: (i, v) => v,
                        label: (i, v) => v,
                      ),
                      wrapped: true,
                      choiceStyle: C2ChoiceStyle(
                          color: Colors.blue),
                    ),
                  ),
          CardButtonComponent(
            onPressed: () {
              setState(() => widget.daysSelect.text = 'hola');
              Navigator.of(context).pop();
            },
            isColored: true,
            title: 'ok',
          ),
        ]
    )
    ;
  }


  static Map<String,dynamic> mapDays = {
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

  List<dynamic> sortDay(List<String> selectedDia){
    List<dynamic> numbers = [];

    for (var element in selectedDia) {
      numbers.add(mapDays[element]);
    }

    numbers.sort();

    return numbers;

  }

  List<String> getDiasString(List<dynamic> numeros){
    List<String> tags = [];
    numeros.forEach((element) {
      if(element< 8) {
        tags.add(daysList.elementAt(element));
      } else{tags.add("Todos los días");}
    });
    return tags;
  }

  List<String> getDias(List<dynamic> numeros){
    List<String> tags = [];
    numeros.forEach((element) {
      tags.add(daysList.elementAt(element));
    });
    return tags;
  }

}