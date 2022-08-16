import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/routing/navigation_service.dart';
import 'package:neurocheck/core/widgets/custom_button.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';
import 'package:neurocheck/modules/tasks/components/mod_task/switch_days_provider.dart';
import 'package:neurocheck/modules/tasks/components/mod_task/switch_range_provider.dart';
import 'package:neurocheck/modules/tasks/components/mod_task/switch_rep_provider.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_app_bar_widget.dart';
import '../../home/components/card_user_details_component.dart';
import '../components/forms/days/multi_choice_provider.dart';
import '../components/forms/days/switch_setting_section_component.dart';
import '../components/forms/days/switch_theme_provider.dart';
import '../components/forms/name_task/name_task_provider.dart';
import '../components/forms/name_task/task_name_text_fields.dart';
import '../components/forms/range/time_picker_component.dart';
import '../components/forms/range/time_range_picker_provider.dart';
import '../components/forms/repetitions/repe_noti_component.dart';
import '../components/forms/repetitions/repe_noti_provider.dart';
import '../components/mod_task/switch_name_provider.dart';
import '../components/mod_task_provider.dart';
import '../models/task_model.dart';

class ModTaskComponent extends HookConsumerWidget {
  const ModTaskComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {

    //control switches
    final switchName = ref.watch(switchNameProvider);
    final switchDays = ref.watch(switchDaysProvider);
    final switchRep = ref.watch(switchRepProvider);
    final switchRange = ref.watch(switchRangeProvider);




    //mod datos
    var nameProvider = ref.read(nameTaskProvider.notifier);
    var days = ref.read(selectDaysMultiChoice.notifier);
    var range = ref.read(timeRangeButtonProvider.notifier);
    var repetitions = ref.read(timeRepetitionProvider.notifier);

    final nametaskFormKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: taskModel.taskName);



    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).iconTheme.color,
          //leading: CustomBackButton(result: ,)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //ver tarea a modificar
              SizedBox(
                height: Sizes.vMarginSmallest(context),
              ),
              CardUserDetailsComponent(
                taskModel: taskModel,
              ),
              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),

              //cambiar nombre
              Row(
                  children:[
                    //todo
                    CustomText.h4(context, 'Cambiar nombre'),
                    SizedBox(
                      width: Sizes.vMarginSmallest(context),
                    ),
                    PlatformSwitch(
                      value: !switchName,
                      onChanged: (value) {
                        ref.watch(switchNameProvider.notifier)
                            .changeState(change: !value);
                      },
                      material: (_, __) {
                        return MaterialSwitchData(
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.blue,
                        );
                      },
                      cupertino: (_, __) {
                        return CupertinoSwitchData(
                          activeColor: AppColors.blue,
                        );
                      },
                    ),
                  ]
              ),
              (!switchName)
                  ? Form(
                        key: nametaskFormKey,
                        child: NameTaskTextFieldsSection(
                            nameController: nameController,
                            onFieldSubmitted: (value) {
                          if (nametaskFormKey.currentState!.validate()) {
                            nameProvider.controllerName(nameController);
                          }
                        },)
                  )
                : SizedBox(height: Sizes.vMarginSmallest(context),),

              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),

              //cambiar días
              Row(
                  children:[
                      //todo hacer que se muestren los dias que habia antes
                      CustomText.h4(context, 'Cambiar días'),
                      SizedBox(
                        width: Sizes.vMarginSmallest(context),
                      ),
                      PlatformSwitch(
                        value: !switchDays,
                        onChanged: (value) {
                          ref.watch(switchDaysProvider.notifier)
                              .changeState(change: !value);
                        },
                        material: (_, __) {
                          return MaterialSwitchData(
                            activeColor: AppColors.white,
                            activeTrackColor: AppColors.blue,
                          );
                        },
                        cupertino: (_, __) {
                          return CupertinoSwitchData(
                            activeColor: AppColors.blue,
                          );
                        },
                      ),
                    ]
              ),
              (!switchDays)
                  ? Container(
                      child: Card(
                        elevation: 6,
                        shadowColor: AppColors.blue,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(Sizes.cardRadius(context)),
                        ),
                        child: SwitchSettingsSectionComponent(separateString(taskModel.days.toString())),
                    ))
                  :  SizedBox(height: Sizes.vMarginSmallest(context),),
              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),

            //cambiar rango
              Row(
                  children:[
                    //todo
                    CustomText.h4(context, 'Cambiar rango horario'),
                    SizedBox(
                      width: Sizes.vMarginSmallest(context),
                    ),
                    PlatformSwitch(
                      value: !switchRange,
                      onChanged: (value) {
                        ref.watch(switchRangeProvider.notifier)
                            .changeState(change: !value);
                      },
                      material: (_, __) {
                        return MaterialSwitchData(
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.blue,
                        );
                      },
                      cupertino: (_, __) {
                        return CupertinoSwitchData(
                          activeColor: AppColors.blue,
                        );
                      },
                    ),
                  ]
              ),
              (!switchRange)
                  ? Container(
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
                    child: TimePickerComponent('${taskModel.begin!} - ${taskModel.end!}'),
                  ))
                  :  SizedBox(height: Sizes.vMarginSmallest(context),),
              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),

              //cambiar rep
              Row(
                  children:[
                    //todo
                    CustomText.h4(context, 'Cambiar minutos repetición'),
                    SizedBox(
                      width: Sizes.vMarginSmallest(context),
                    ),
                    PlatformSwitch(
                      value: !switchRep,
                      onChanged: (value) {
                        ref.watch(switchRepProvider.notifier)
                            .changeState(change: !value);
                      },
                      material: (_, __) {
                        return MaterialSwitchData(
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.blue,
                        );
                      },
                      cupertino: (_, __) {
                        return CupertinoSwitchData(
                          activeColor: AppColors.blue,
                        );
                      },
                    ),
                  ]
              ),
              (!switchRep)
                  ? SizedBox(
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
                      child: RepeNotiComponent(hora: taskModel.numRepetition!, modo: 'mod',))
                    )
                  :  SizedBox(height: Sizes.vMarginSmallest(context),),

              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),

            //todo
            Row(children: [
              CupertinoButton(
                child: CustomText.h4(context,'Cancelar',color: AppColors.lightRed,),
                onPressed:() {
                  NavigationService.goBack(context);
                }
                ),
              SizedBox(
                width: Sizes.vMarginSmall(context),
              ),
              CupertinoButton(
                  child: CustomText.h4(context,'Modificar',color: AppColors.blue,),
                  onPressed:() {
                    //TODO
                    //NavigationService.goBack(context);
                  }
              )
            ])
        ])
      ),
    )
    );
  }

  bool toggle(bool valor){
    return !valor;
  }

  Widget getSwitchWidget(bool switchButton, SwitchButton  ref){
    return PlatformSwitch(
      value: switchButton,
      onChanged: (value) {
        ref.changeState(change: !value);
      },
      material: (_, __) {
        return MaterialSwitchData(
          activeColor: AppColors.white,
          activeTrackColor: AppColors.blue,
        );
      },
      cupertino: (_, __) {
        return CupertinoSwitchData(
          activeColor: AppColors.blue,
        );
      },
    );
  }

  List<String> separateString(String string){
    String delete = string.replaceAll('[', '');
    String delete2 = delete.replaceAll(']', '');
    var split = string.split(',');
    return split;

  }



}

