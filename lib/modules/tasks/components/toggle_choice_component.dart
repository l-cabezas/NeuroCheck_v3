import 'dart:developer';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/routing/navigation_service.dart';
import 'package:neurocheck/modules/simple_notifications/notifications.dart';
import 'package:neurocheck/modules/tasks/components/forms/days/switch_theme_provider.dart';
import 'package:neurocheck/modules/tasks/components/toggle_theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../../core/services/localization_service.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/styles/sizes.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_tile_component.dart';
import '../../../auth/repos/user_repo.dart';
import '../../../core/utils/flush_bar_component.dart';
import '../models/task_model.dart';
import '../repos/task_repo.dart';
import '../repos/utilities.dart';
import 'forms/days/multi_choice_provider.dart';
import 'forms/days/switch_setting_section_component.dart';
import 'forms/range/time_picker_component.dart';
import 'forms/range/time_range_picker_provider.dart';
import 'forms/repetitions/repe_noti_component.dart';
import 'forms/repetitions/repe_noti_provider.dart';


class ToggleChoiceComponent extends ConsumerWidget {
  ToggleChoiceComponent( {required this.taskModel,Key? key})
      : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    final toggleValue = ref.watch(toggleButtonProviderAdd);
    final multiChoiceValue = ref.watch(selectDaysMultiChoice);
    var switchValue = !ref.watch(switchButtonProvider);
    var taskRepo = ref.watch(tasksRepoProvider);

    var days = ref.read(selectDaysMultiChoice.notifier);
    var range = ref.read(timeRangeButtonProvider.notifier);
    var repetitions = ref.read(timeRepetitionProvider.notifier);
    var userRepo = ref.watch(userRepoProvider);


    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          //eleccion días
          (toggleValue == 0)
            ? Card(
                  elevation: 6,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Sizes.cardRadius(context)),
                  ),
                  child: Column(

                      children:[
                        SizedBox(
                          height: Sizes.vMarginSmall(context),
                        ),
                        ToggleSwitch(
                          minWidth: 160.0,
                          //cornerRadius: 20.0,
                          activeBgColors: [[Colors.green], [Colors.green]],
                          activeFgColor: Colors.white,
                          inactiveBgColor: AppColors.lightGray,
                          inactiveFgColor: Colors.black,
                          initialLabelIndex: (ref.read(switchButtonProviderAdd.notifier).state == true) ? 0 : 1,
                          totalSwitches: 2,
                          radiusStyle: true,
                          labels: ['No repetir', 'Elegir días'],
                          onToggle: (index) {
                            print('switched to: $index');
                            var i = (index == 0)
                                ? true
                                : false;

                            ref.watch(switchButtonProviderAdd.notifier).changeState(change: i);
                            switchValue = ref.read(switchButtonProviderAdd.notifier).state;
                            log('SWITCH VALUE ${switchValue}');
                          },
                        ),
                        SizedBox(height: Sizes.vMarginSmallest(context),),
                        ChooseDaySectionComponent([]),

                        SizedBox(height: Sizes.vMarginMedium(context),),

                        Row(
                            children: [
                              SizedBox(width: Sizes.vMarginHighest(context)*1.2,),
                              CupertinoButton(
                                  child: CustomText.h4(context,'Cancelar',color: AppColors.red),
                                  onPressed: (){

                                  }),
                              SizedBox(width: Sizes.vMarginHighest(context)*3.3,),

                              CupertinoButton(
                                  child: CustomText.h4(context,'Ok',color: AppColors.blue),
                                  onPressed: () async {
                                    var sup = userRepo.userModel?.uidSupervised;
                                    //para luego poder cancelar las notificaciones
                                    //si no es supervisor activamos las notis

                                    if(sup != ''){
                                      //disp boss no hay notis
                                      //taskRepo.cancelNotification(taskModel.idNotification!);
                                      taskRepo.updateTaskBoss({
                                        'idNotification': [],
                                        'days': saveDays(days.tags.toString()),
                                        'lastUpdate': Timestamp.fromDate(DateTime.now()),
                                        'oneTime': (!switchValue).toString(),
                                        'isNotificationSet': 'false',
                                      },
                                          taskId: taskModel.taskId
                                      ).then((value) {
                                        FlushBarNotification.showError(
                                            context: context,
                                            message: 'Días Modificados');
                                    //    NavigationService.goBack(context);
                                      });
                                    }else{
                                      //se cambian días, borramos notificacion y cambiamos días, si es oneTime y su ultima mod
                                      taskRepo.cancelNotification(taskModel.idNotification!);
                                      taskRepo.updateTask({
                                        'days': saveDays(days.tags.toString()),
                                        'lastUpdate': Timestamp.fromDate(DateTime.now()),
                                        'oneTime': (!switchValue).toString(),
                                        'isNotificationSet': 'false',
                                      },
                                          taskId: taskModel.taskId
                                      ).then((value) {
                                        FlushBarNotification.showError(
                                            context: context,
                                            message: 'Días Modificados');
                                        //NavigationService.goBack(context);
                                      });
                                    }



                                  })
                            ]
                        ),



                      ])
          )
          : SizedBox(),
          //eleccion rango
          (toggleValue == 1)
              ? Card(
              elevation: 6,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(Sizes.cardRadius(context)),
              ),
              child: Container(

                  child: Card(
                    elevation: 6,
                    shadowColor: AppColors.blue,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(Sizes.cardRadius(context)),
                    ),
                    child: Column(children:[
                      TimePickerComponent('${taskModel.begin!} - ${taskModel.end!}'),
                      SizedBox(height: Sizes.vMarginMedium(context),),

                      Row(
                          children: [
                            SizedBox(width: Sizes.vMarginHighest(context)*1.2,),
                            CupertinoButton(
                                child: CustomText.h4(context,'Cancelar',color: AppColors.red),
                                onPressed: (){

                                }),
                            SizedBox(width: Sizes.vMarginHighest(context)*3.3,),

                            CupertinoButton(
                                child: CustomText.h4(context,'Ok',color: AppColors.blue),
                                onPressed: (){
                                  var sup = userRepo.userModel?.uidSupervised;
                                  //para luego poder cancelar las notificaciones
                                  //si no es supervisor activamos las notis

                                  //hora inicio y fin

                                  if(sup != ''){
                                    //disp boss no hay notis
                                    //taskRepo.cancelNotification(taskModel.idNotification!);
                                    taskRepo.updateTaskBoss({
                                      'begin': range.getIniHour(),
                                      'end': range.getfinHour(),
                                      'idNotification': [],
                                      'lastUpdate': Timestamp.fromDate(DateTime.now()),
                                      'isNotificationSet': 'false',
                                    },
                                        taskId: taskModel.taskId
                                    ).then((value) {
                                      FlushBarNotification.showError(
                                          context: context,
                                          message: 'Rango horario modificado');
                                  //    NavigationService.goBack(context);
                                    });
                                  }else{
                                    //se cambian días, borramos notificacion y cambiamos días, si es oneTime y su ultima mod
                                    taskRepo.cancelNotification(taskModel.idNotification!);
                                    taskRepo.updateTask({
                                      'begin': range.getIniHour(),
                                      'end': range.getfinHour(),
                                      'lastUpdate': Timestamp.fromDate(DateTime.now()),
                                      'isNotificationSet': 'false',
                                    },
                                        taskId: taskModel.taskId
                                    ).then((value) {
                                      FlushBarNotification.showError(
                                          context: context,
                                          message: 'Rango horario modificado');
                                   //   NavigationService.goBack(context);
                                    });
                                  }
                                })
                          ]
                      ),
                    ])
                  )),
          )
              : SizedBox(),
          //eleccion de repeticion
          (toggleValue == 2)
              ? Card(
            elevation: 6,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(Sizes.cardRadius(context)),
            ),
            child: Container(
                child: Card(
                  elevation: 6,
                  shadowColor: AppColors.blue,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(Sizes.cardRadius(context)),
                  ),
                  child: Column(children:[
                    RepeNotiComponent(modo: 'mod',),
                    SizedBox(height: Sizes.vMarginMedium(context),),

                    Row(
                        children: [
                          SizedBox(width: Sizes.vMarginHighest(context)*1.2,),
                          CupertinoButton(
                              child: CustomText.h4(context,'Cancelar',color: AppColors.red),
                              onPressed: (){

                              }),
                          SizedBox(width: Sizes.vMarginHighest(context)*3.3,),

                          CupertinoButton(
                              child: CustomText.h4(context,'Ok',color: AppColors.blue),
                              onPressed: (){
                                var sup = userRepo.userModel?.uidSupervised;
                                //para luego poder cancelar las notificaciones
                                //si no es supervisor activamos las notis

                                //cada cuantos minutos se repite

                                if(sup != ''){
                                  //disp boss no hay notis
                                  //taskRepo.cancelNotification(taskModel.idNotification!);
                                  taskRepo.updateTaskBoss({
                                    'numRepetition': repetitions.getHr(),
                                    'idNotification': [],
                                    'lastUpdate': Timestamp.fromDate(DateTime.now()),
                                    'isNotificationSet': 'false',
                                  },
                                      taskId: taskModel.taskId
                                  ).then((value) {
                                    FlushBarNotification.showError(
                                        context: context,
                                        message: 'Tiempo notificicaciones modificado');
                             //       NavigationService.goBack(context);
                                  });
                                }else{
                                  //se cambian días, borramos notificacion y cambiamos días, si es oneTime y su ultima mod
                                  taskRepo.cancelNotification(taskModel.idNotification!);
                                  taskRepo.updateTask({
                                    'numRepetition': repetitions.getHr(),
                                    'lastUpdate': Timestamp.fromDate(DateTime.now()),
                                    'isNotificationSet': 'false',
                                  },
                                      taskId: taskModel.taskId
                                  ).then((value) {
                                    FlushBarNotification.showError(
                                        context: context,
                                        message: 'Tiempo notificicaciones modificado');
                            //        NavigationService.goBack(context);
                                  });
                                }
                              })
                        ]
                    ),
                  ]),
                )),
          )
              : SizedBox(),
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
      print(element.toString());
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
