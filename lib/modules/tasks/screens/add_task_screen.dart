import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/routing/navigation_service.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/widgets/custom_button.dart';
import 'package:neurocheck/modules/tasks/components/forms/name_task/name_task_provider.dart';
import 'package:neurocheck/modules/tasks/components/forms/range/time_range_picker_provider.dart';
import 'package:neurocheck/modules/tasks/components/forms/repetitions/repe_noti_provider.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';

import '../../../core/screens/popup_page_nested.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/utils/dialog_message_state.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../simple_notifications/notifications.dart';
import '../components/forms/days/multi_choice_provider.dart';
import '../components/forms/days/switch_setting_section_component.dart';
import '../components/forms/days/switch_theme_provider.dart';
import '../components/forms/name_task/task_name_text_fields.dart';
import '../components/forms/range/time_picker_component.dart';
import '../components/forms/repetitions/repe_noti_component.dart';
import '../viewmodels/task_provider.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var addTaskProvider = ref.watch(taskProvider.notifier);

    //empezaría en true
    final switchValue = !ref.watch(switchButtonProvider);

    var nameProvider = ref.read(nameTaskProvider.notifier);
    var days = ref.read(selectDaysMultiChoice.notifier);
    var range = ref.read(timeRangeButtonProvider.notifier);
    var repetitions = ref.read(timeRepetitionProvider.notifier);

    final nametaskFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: '');


    log('sw value $switchValue');
    return PopUpPageNested(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
            children: <Widget>[
              //const UserInfoComponent(),
              Form(
                  key: nametaskFormKey,
                  child: NameTaskTextFieldsSection(
                    nameController: nameController,
                    onFieldSubmitted: (value) {
                      if (nametaskFormKey.currentState!.validate()) {
                        nameProvider.controllerName(nameController);
                      }
                    },
                  )),
              SizedBox(
                height: Sizes.vMarginSmallest(context),
              ),
              Container(
                  child:
                  Card(
                elevation: 6,
                shadowColor: AppColors.blue,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Sizes.cardRadius(context)),
                ),
                child: SwitchSettingsSectionComponent([]),
              )),
              //eleccion de días

              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
              //eleccion rango horario
              Container(
                  height: 150,
                  width: 400,
                  child: Card(
                    elevation: 6,
                    shadowColor: AppColors.blue,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Sizes.cardRadius(context)),
                    ),
                    child: TimePickerComponent('00:00 - 00:00', switchValue),
                  )),

              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
              Container(
                  height: 150,
                  width: 400,
                  child: Card(
                      elevation: 6,
                      shadowColor: AppColors.blue,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Sizes.cardRadius(context)),
                      ),
                      child: RepeNotiComponent(hora: '',modo: 'add',))),
              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),
              CustomButton(
                text: 'Añadir',
                onPressed: () {
                bool ok = checkRange(range.getIniHour(), range.getfinHour(), repetitions.getHr());
                  if (ok){
                    if(days.tags.toString()== '[]'){
                      days.tags.add(getStrDay(DateTime.now().weekday));
                    };
                    //para luego poder cancelar las notificaciones
                    List<int> id =
                    setNotiHours(range.getIniHour(), range.getfinHour(), repetitions.getHr(),saveDays(days.tags.toString()),switchValue);

                    TaskModel task = TaskModel(
                        taskName: nameProvider.getNameTask(),
                        days: saveDays(days.tags.toString()),
                        //'repeat': FieldValue.arrayUnion(saveDays(days.tags.toString()))
                        //saveDays(days.tags.toString()),
                        idNotification: id,
                        oneTime: (!switchValue).toString(),
                        notiHours: notiHours(range.getIniHour(), range.getfinHour(), repetitions.getHr()),
                        begin: range.getIniHour(),
                        end: range.getfinHour(),
                        editable: 'true',
                        done: 'false',
                        numRepetition: repetitions.getHr(),
                        taskId: '');
                    log(' ADD SCREEN ${task.taskName} ${task.days!} ${task.begin!}  ${task.end!}  ${task.editable!} ${task.done!}  ${task.numRepetition!}');
                    log(' NOTI HOURS ${task.notiHours}');

                    addTaskProvider.addSingleTask(context, task: task);
                    nameController.clear();
                  } else{
                    AppDialogs.showErrorNeutral(context,message: tr(context).rangeWarning);
                  }

                },
              ),
              //tasksRepoProvider
              //
              //const LogoutComponent(),
            ],
          ),
        ),
      ),
    );
  }

  //hago esto para gestionar de forma más fácil la base de datos
  List<String> saveDays(String days){
    if(days == '[Todos los días]'){
      days = '[Lunes, Martes, Miércoles, Jueves, Sábado, Domingo]';
    }

    days = reformDays(days);

    var amountOfDays = days.split(' ');

    return amountOfDays;

    //return days;
  }

  Future<int> stablishNoti(int day, String hora, bool switchValue){
    var h = hora.split(':');
    log('Stablish $day${h[0]}${h[1]}');
    //dependiendo si es una notificacion para solo ese día o programada
    log('sw value Noti $switchValue');
    return (switchValue)
        ?  createReminderNotification(day,int.parse(h[0]),int.parse(h[1]))
        :  createTaskToDoNotification(int.parse(h[0]),int.parse(h[1]));
  }

  String reformDays(String days){
    var left = days.replaceAll('[','');
    var right = left.replaceAll(']','');
    var center = right.replaceAll(',','');
    return center;

  }


  List<int> setNotiHours(String ini, String fin, String avisar, List<String> day, bool switchValue){
    List<int> list = [];
    var splitIni = ini.split(':');
    //pasamos all a minutos
    int iniH = int.parse(splitIni[0])*60 + int.parse(splitIni[1]);

    var splitFin = fin.split(':');
    //pasamos all a minutos
    int finH = int.parse(splitFin[0])*60 + int.parse(splitFin[1]);

    int cantDias = day.length;

    for(int j = 0; j< cantDias;j++) {
      int chooseDay = getNumDay(day.elementAt(j));
      for (int i = iniH; i <= finH; i += int.parse(avisar)) {
        var duration = Duration(minutes: i);
        //log('HORAS.ADD ${duration.inHours}:${duration.inMinutes.remainder(60)}');
        // para evitar que guarde 8 en vez de 08

        if (duration.inMinutes.remainder(60) < 10) {
         stablishNoti(chooseDay,
              '${duration.inHours}:0${duration.inMinutes.remainder(60)}',switchValue).then((value) => list.add(value));
        } else {

          stablishNoti(chooseDay,
              '${duration.inHours}:${duration.inMinutes.remainder(60)}',switchValue).then((value) => list.add(value));
        }
      }
    }
    return list;
  }


  //calcular las horas a las que hay que avisar

  List<String> notiHours(String ini, String fin, String avisar){
    var horas = [''];
    var splitIni = ini.split(':');
    //pasamos all a minutos
    int iniH = int.parse(splitIni[0])*60 + int.parse(splitIni[1]);

    var splitFin = fin.split(':');
    //pasamos all a minutos
    int finH = int.parse(splitFin[0])*60 + int.parse(splitFin[1]);

    for(int i = iniH; i <= finH ; i += int.parse(avisar) ){
      var duration = Duration(minutes:i);
      //log('HORAS.ADD ${duration.inHours}:${duration.inMinutes.remainder(60)}');
      // para evitar que guarde 8 en vez de 08

      if(duration.inMinutes.remainder(60)< 10){
        horas.add('${duration.inHours}:0${duration.inMinutes.remainder(60)}');
      }else{
        horas.add('${duration.inHours}:${duration.inMinutes.remainder(60)}');
      }

    }

    horas.removeWhere((item) => item == '');

    return horas;
  }
  
  bool checkRange(String ini, String fin, String avisar){

    var splitIni = ini.split(':');
    //pasamos all a minutos
    int iniH = int.parse(splitIni[0])*60 + int.parse(splitIni[1]);

    var splitFin = fin.split(':');
    //pasamos all a minutos
    int finH = int.parse(splitFin[0])*60 + int.parse(splitFin[1]);

    if(finH - iniH  < int.parse(avisar)) {
      return false;
    }
    
    return true;
  }

  int getNumDay(String day){
    int num = 0;
    switch(day){
      case 'Lunes': num = 1; break;
      case 'Martes': num = 2; break;
      case 'Miércoles': num = 3; break;
      case 'Jueves': num = 4; break;
      case 'Viernes': num = 5; break;
      case 'Sábado': num = 6; break;
      case 'Domingo': num = 7; break;
    }

    return num;
  }

  String getStrDay(int day){
    String d = '';
    switch(day){
      case 1: d = 'Lunes'; break;
      case 2: d = 'Martes'; break;
      case 3: d = 'Miércoles'; break;
      case 4: d = 'Jueves'; break;
      case 5: d = 'Viernes'; break;
      case 6: d = 'Sábado'; break;
      case 7: d = 'Domingo'; break;
    }

    return d;

  }

}
