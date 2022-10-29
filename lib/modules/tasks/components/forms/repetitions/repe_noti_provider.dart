import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/widgets/custom_button.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';
import 'package:neurocheck/modules/tasks/components/forms/range/time_range_picker_provider.dart';

import '../../../../../core/styles/sizes.dart';


//Create a Provider
final timeRepetitionProvider = StateNotifierProvider.autoDispose<TimeRepetitionButton, String>((ref) {
  return TimeRepetitionButton(ref);
});

class TimeRepetitionButton extends StateNotifier<String> {
  final Ref ref;

  String minutos_repetir = '0';

  static String hr = '';

  Picker ps = Picker(
      adapter: NumberPickerAdapter(
          data: [
             NumberPickerColumn(
              initValue: 1,
              begin: 0,
              end: 999,
            ),
          ]
      ),
      delimiter: [
        PickerDelimiter(
            child: Container(
              width: 70.0,
              alignment: Alignment.center,
              child: const Text('Minutos'),//Icon(Icons.more_vert),
            ))
      ],
      hideHeader: true,
      title: const Text("Selecciona cada cuanto quieres que se repita"),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
          var split = value.toString().replaceAll('[', '');
          split = split.replaceAll(']', '');
          hr = split;
      }
      );

  String getHr(){
    return hr;
  }

  clean(){
    hr='';
  }
  List<Widget> actions = [];

  TimeRepetitionButton(this.ref) : super('');

  String getMinute(){
    return hr;
  }

  showPicker(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Cada cuantos minutos repetir"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //CustomText.h4(context,"Cada cuantos minutos se repite cada notificacion"),
                  ps.makePicker(),
                  SizedBox(width: Sizes.vMarginHigh(context),),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                      children: [
                    //todo
                    CupertinoButton(
                        child: CustomText.h3(context,'Cancelar',color: AppColors.red),
                        onPressed: (){
                          //ref.refresh(timeRepetitionProvider);
                          navigationPop(context);
                        }),
                    SizedBox(width: Sizes.vMarginHigh(context),),
                    CupertinoButton(
                        child: CustomText.h3(context,'Ok',color: AppColors.blue),
                        onPressed: (){
                          //log('okey');
                          ps.onConfirm!(ps, ps.selecteds);
                          //var inputFormat = DateFormat.Hm();
                          //var inputDateInicio = inputFormat.parse(hr);
                          ref.refresh(timeRepetitionProvider);
                          navigationPop(context);
                        })
                  ])

                ],
              ),
            ),
          );
        });
  }

  navigationPop(BuildContext context) {
    Navigator.pop(context);
  }

  static String parsearHora(DateTime date){
    var control = '';
    String hora = '';
    if (date.minute.toString().length == 1) {
      control = '0${date.minute}';
    } else {
      control = date.minute.toString();
    }
    hora = ('${date.hour}:$control');
    return hora;
  }


}