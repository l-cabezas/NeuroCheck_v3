import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

import '../../../../../core/styles/sizes.dart';


//Create a Provider
final timeRangeButtonProvider = StateNotifierProvider<TimeRangeButton, String>((ref) {
  return TimeRangeButton(ref);
});

class TimeRangeButton extends StateNotifier<String> {
  final Ref ref;

  String horaInicial = '00:00';
  String horaFinal = '00:00';

  static String hf = '00:00';
  static String hi = '00:00';

  String getIniHour(){
    return hi;
  }

  String getfinHour(){
    return hf;
  }

  clean(){
    hi='';
    hf ='';
  }

  Picker ps = Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kHM_AP),
      onConfirm: (Picker picker, List value) {
        var ini= (picker.adapter as DateTimePickerAdapter).value;
         hi = parsearHora(ini!);
        //valorINICIAL = ini!.hour.toString() +':'+ ini.minute.toString();
      });
  Picker pe = Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(type: PickerDateTimeType.kHM_AP) ,
      onConfirm: (Picker picker, List value) {
        var ini= (picker.adapter as DateTimePickerAdapter).value;
        hf = parsearHora(ini!);
        //ini!.hour.toString() +':'+ ini.minute.toString();
      });

  List<Widget> actions = [];

  TimeRangeButton(this.ref) : super('');

  String getHours(){
    return hi +' - ' + hf;
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

  showPicker(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //todo
            title: const Text("Elija rango horario"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text("Inicio:"),
                  ps.makePicker(),
                  const Text("Fin:"),
                  pe.makePicker(),

                  SizedBox(
                    height: Sizes.vMarginSmall(context),
                  ),

                  Row(
                      children: [
                        SizedBox(
                            height: 50,
                            width: 120,
                            child: CupertinoButton(

                                child: CustomText.h4(context,'Cancelar',color: AppColors.red,),
                                onPressed: (){
                                  ref.refresh(timeRangeButtonProvider);
                                  navigationPop(context);
                                })),

                        SizedBox(
                          width: Sizes.vMarginSmallest(context),
                        ),

                        SizedBox(
                        height: 50,
                        width: 120,
                        child: CupertinoButton(
                          child: CustomText.h4(context,'Guardar',color: AppColors.blue,),
                          onPressed: (){
                            //log('okey');

                            ps.onConfirm!(ps, ps.selecteds);
                            pe.onConfirm!(pe, pe.selecteds);

                            horaInicial = hi;
                            horaFinal = hf;

                            var inputFormat = DateFormat.Hm();
                            var inputDateInicio = inputFormat.parse(hi);
                            var inputDateFin = inputFormat.parse(hf);
                            if(inputDateInicio.isAfter(inputDateFin)){
                              ///ShowInfo().showMyDialog(context, 'La hora de inicio va antes que la final', 'Casi es mejor cambiarla');
                            }

                            //state = '$horaInicial - $horaFinal';
                            //log(state);
                            ref.refresh(timeRangeButtonProvider);
                            navigationPop(context);
                          }),),



                    ]),
            ],
              ),
            ),
          );
        });
  }

  navigationPop(BuildContext context) {
    Navigator.pop(context);
  }

  firstPicker(Picker ps){
     ps = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kHM_AP),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
          var ini= (picker.adapter as DateTimePickerAdapter).value;
          horaInicial = parsearHora(ini!);
          //valorINICIAL = ini!.hour.toString() +':'+ ini.minute.toString();
        });
    ps.makePicker();
  }



}