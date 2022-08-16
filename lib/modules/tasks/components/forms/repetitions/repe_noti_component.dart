import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/components/forms/repetitions/repe_noti_provider.dart';
import 'package:neurocheck/modules/tasks/components/forms/range/time_range_picker_provider.dart';

import '../../../../../core/styles/sizes.dart';
import '../../../../../core/widgets/custom_text.dart';


class RepeNotiComponent extends ConsumerWidget {
  RepeNotiComponent({required this.hora, Key? key, required this.modo}) : super(key: key);
  String hora = '';
  String modo = '';


  @override
  Widget build(BuildContext context, ref) {
    //log(modo);
    final repeNoti = ref.watch(timeRepetitionProvider.notifier);
    String hours = ref.read(timeRangeButtonProvider.notifier).getHours();
    bool go = getRange(hours, repeNoti.getHr());
    //log(hora);
    //log(repeNoti.getHr());
    return Container(
      padding: EdgeInsets.all(10),
        child: Column(
        children: [
          //todo
          (modo == 'add')
              ? CustomText.h4(
            context,
            '¿Cada cuantos minutos quieres '
                'que se repita la notificación?', //todo
            color: Theme.of(context).textTheme.headline4!.color,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
          : SizedBox(
            height: Sizes.vMarginSmallest(context),
          ),
          SizedBox(
            height: Sizes.vMarginMedium(context),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            (repeNoti.getHr() != '')
                ? //todo
                CustomText.h4(
                context,
                'Se te avisara cada ',
                  color: Theme.of(context).textTheme.headline4!.color,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  )
                : (modo != 'add')
                    ? CustomText.h4(
                      context,
                      'Se te avisara cada ',
                      color: Theme.of(context).textTheme.headline4!.color,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                    : CustomText.h4(context, ''),


              SizedBox(
                width: Sizes.vMarginSmallest(context),
              ),
              GestureDetector(
                  onTap: (){
                    repeNoti.showPicker(context);
                    //log(timePicker.state);
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Card(
                        elevation: 6,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Sizes.cardRadius(context)),
                        ),
                        child:Center( child: CustomText.h4(
                          context,
                          (modo == 'add')
                              ? repeNoti.getHr()
                              : (repeNoti.getHr() != '')
                                  ? repeNoti.getHr()
                                  : hora,
                          color: Theme.of(context).textTheme.headline4!.color,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),)
                          //todo
                        /*child:(repeNoti.getRange())
                            ? Center(child: CustomText.h3(context,'repeNoti.minutos_repetir'),)
                            : CustomText.h3(context,'No puedes repetirlo tantas veces'),*/
                      )
                  )
              ),
              SizedBox(
                width: Sizes.vMarginSmallest(context),
              ),
              (repeNoti.getHr() != '')
                  ? CustomText.h4(
                            context,
                            'minutos. ',
                            color: Theme.of(context).textTheme.headline4!.color,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          )
                  : (modo != 'add')
                    ? CustomText.h4(
                          context,
                          'minutos. ',
                          color: Theme.of(context).textTheme.headline4!.color,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                    :CustomText.h4(context, ''),

            ],),

        ]));

  }

  bool getRange(String hours, String rep){
    bool p = false;
    String ini = hours;
    int idx = ini.indexOf("-");
    List parts = [ini.substring(0,idx).trim(), ini.substring(idx+1).trim()];
    if(parts.toString() != '[, ]'){
      int inicio = caculateMin(parts[0]);
      int fin = caculateMin(parts[1]);
      int total = inicio + fin;
      (rep != '')
          ? (int.parse(rep) > total)
          ? p = true
          : p = false
          : p = false;
    }
    return p;
  }

  int caculateMin(String dots){
    int idx = dots.indexOf(":");
    List parts = [dots.substring(0,idx).trim(), dots.substring(idx+1).trim()];
    int hour = int.parse(parts[0]);
    int min = int.parse(parts[1]);
    int allMinutes = hour*60 + min;
    return allMinutes;
  }


}