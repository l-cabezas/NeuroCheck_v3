import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/widgets/custom_button.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';
import 'package:neurocheck/modules/tasks/components/forms/name_task/name_task_provider.dart';
import 'package:neurocheck/modules/tasks/components/forms/range/time_range_picker_provider.dart';
import 'package:neurocheck/modules/tasks/components/forms/repetitions/repe_noti_provider.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../auth/repos/user_repo.dart';
import '../../../../core/screens/popup_page_nested.dart';
import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/flush_bar_component.dart';
import '../../../../core/widgets/custom_tile_component.dart';
import '../../components/forms/days/multi_choice_provider.dart';
import '../../components/forms/days/switch_setting_section_component.dart';
import '../../components/forms/days/switch_theme_provider.dart';
import '../../components/forms/name_task/task_name_text_fields.dart';
import '../../components/forms/range/time_picker_component.dart';
import '../../components/forms/repetitions/repe_noti_component.dart';
import '../../repos/task_repo.dart';
import '../../repos/utilities.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var userRepo = ref.watch(userRepoProvider);
    var taskRepo = ref.watch(tasksRepoProvider);


    //empezaría en true
    var switchValue = !ref.watch(switchButtonProvider);
    var nameProvider = ref.read(nameTaskProvider.notifier);
    var days = ref.read(selectDaysMultiChoice.notifier);
    var range = ref.read(timeRangeButtonProvider.notifier);
    var repetitions = ref.read(timeRepetitionProvider.notifier);

    final nametaskFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: '');



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
                  Column(
                      children:[
                          Card(
                            elevation: 6,
                            shadowColor: AppColors.blue,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizes.cardRadius(context)),
                            ),
                            child: Column(children:[
                              CustomTileComponent(
                                title: tr(context).repeatAdd,
                                leadingIcon: Icons.calendar_today_rounded,
                              ),
                              SizedBox(height: Sizes.vMarginSmallest(context),),
                              ToggleSwitch(
                                minWidth: 160.0,
                                //cornerRadius: 20.0,
                                activeBgColors: [[AppColors.blue], [AppColors.blue]],
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
                              SwitchSettingsSectionComponent([]),
                            ])//SwitchSettingsSectionComponent([]),
                          )
                      ]
                  )
              ),
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
                  //height: 150,
                  width: 400,
                  child: Card(
                      elevation: 6,
                      shadowColor: AppColors.blue,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Sizes.cardRadius(context)),
                      ),
                      child: RepeNotiComponent(modo: 'add',)
                  )
              ),

              SizedBox(
                height: Sizes.vMarginMedium(context),
              ),

              checkDatosAll(nameProvider.getNameTask(),
                  days.tags.toString(),
                  !(switchValue),
                  range.getIniHour(),
                  range.getfinHour(),repetitions.getMinuteInt())
              ?CustomButton(
                text: 'Añadir',
                onPressed: () async {
                bool ok = true;//checkRange(range.getIniHour(), range.getfinHour(), repetitions.getHr());
                  String isNotificationSet = 'false';
                  if (ok){
                    if(days.tags.toString()== '[]'){
                      days.tags.add(getStrDay(DateTime.now().weekday));
                    };

                    List<int> id = [];

                    TaskModel task = TaskModel(
                        taskName: nameProvider.getNameTask(),
                        days: saveDays(days.tags.toString()),
                        idNotification: id,
                        oneTime: (!switchValue).toString(),
                        notiHours: notiHours(range.getIniHour(), range.getfinHour(), repetitions.getHr()),
                        begin: range.getIniHour(),
                        end: range.getfinHour(),
                        editable: 'false',
                        done: 'false',
                        numRepetition: repetitions.getMinuteInt(),
                        lastUpdate: Timestamp.fromDate(DateTime.now()),
                        taskId: '',
                        isNotificationSet: 'false');


                    taskRepo.addDocToFirebaseBoss(task)
                        .then((value) {
                      AppDialogs.addTaskOK(context,
                          message: tr(context).addTaskDone);

                      range.clean();
                      range.ref.refresh(timeRangeButtonProvider);

                      days.clean();
                      days.ref.refresh(selectDaysMultiChoice);

                      repetitions.clean();
                      repetitions.ref.refresh(timeRepetitionProvider);

                      ref.refresh(switchButtonProviderAdd);
                      ref.refresh(switchButtonProvider);

                      ref.watch(timeRepetitionProvider.notifier).setChoosen(true);

                      nameController.clear();
                    }
                    );
                  } else{
                    AppDialogs.showErrorNeutral(context,message: tr(context).rangeWarning);
                  }

                },
              )
                  : CustomButton(
                  text: 'Añadir',
                  buttonColor: AppColors.grey,
                  onPressed: (){
                    AppDialogs.showWarning(context);
                  }),
              //tasksRepoProvider
              //
              //const LogoutComponent(),
            ],
          ),
        ),
      ),
    );
  }

  bool checkDatosAll(String name, String days, bool switchValue,
      String begin, String end, int numRepetition){
    bool check = false;
    log(name + days + begin+ end + numRepetition.toString() );

    //dias
    if(switchValue)
    {if (name != '' && days.isNotEmpty && begin != ''
        && end != '' && numRepetition !=0){
      check = true;
    }}
    else{
      //oneTime
      {if (name != '' && begin != ''
          && end != '' && numRepetition !=0){
        check = true;
      }}
    }
    return check;

  }


}
