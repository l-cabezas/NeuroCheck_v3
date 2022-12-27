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
import '../../../../core/routing/navigation_service.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/screens/popup_page_nested.dart';
import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/flush_bar_component.dart';
import '../../../../core/widgets/custom_tile_component.dart';
import '../../../../core/widgets/loading_indicators.dart';
import '../../../notifications/models/notiControl_model.dart';
import '../../../notifications/viewmodels/notiControl_provider.dart';
import '../../components/forms/days/multi_choice_provider.dart';
import '../../components/forms/days/switch_setting_section_component.dart';
import '../../components/forms/days/switch_theme_provider.dart';
import '../../components/forms/name_task/task_name_text_fields.dart';
import '../../components/forms/range/time_picker_component.dart';
import '../../components/forms/repetitions/repe_noti_component.dart';
import '../../repos/task_repo.dart';
import '../../repos/utilities.dart';
import '../../viewmodels/task_provider.dart';

class AddTaskScreenBoss extends HookConsumerWidget {
  const AddTaskScreenBoss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //empezaría en true
   // var switchValue = !ref.watch(switchButtonProvider);
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
                              ChooseDaySectionComponent([]),
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
                    child: TimePickerComponent('00:00 - 00:00'),
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

              Consumer(
                  builder: (context, ref, child) {
                    final taskLoading = ref.watch(
                      taskProvider.select((state) =>
                          state.maybeWhen(
                              loading: () => true, orElse: () => false)),
                    );
                    return taskLoading
                        ? LoadingIndicators.instance.smallLoadingAnimation(
                      context,
                      width: Sizes.loadingAnimationButton(context),
                      height: Sizes.loadingAnimationButton(context),
                    )
                        :
                  CustomButton(
                text: 'Añadir',
                onPressed: () async {

                        if(days.tags.toString()== '[]'){
                          days.tags.add(getStrDay(DateTime.now().weekday));
                        }

                      if (repetitions.getBoth() != 0) {
                        List<int> id = [];
                      // no puede repertirse cada más minutos que rango hay
                       if(range.getSumaRange() > repetitions.getBoth()) {
                              TaskModel task = TaskModel(
                                  taskName: nameProvider.getNameTask(),
                                  days: saveDays(days.tags.toString()),
                                  idNotification: id,
                                  notiHours: notiHours(range.getIniHour(),
                                      range.getfinHour(), repetitions.getBt()),
                                  begin: range.getIniHour(),
                                  end: range.getfinHour(),
                                  editable: 'false',
                                  done: 'false',
                                  numRepetition: repetitions.getBoth(),
                                  lastUpdate:
                                      Timestamp.fromDate(DateTime.now()),
                                  taskId: '',
                                  isNotificationSet: 'false',
                                  cancelNoti: 'false'
                                );

                              ref
                                  .read(taskProvider.notifier)
                                  .addDocToFirebaseBoss(context, task);

                            }else{
                                  AppDialogs.showWarningAddRange(context);
                            }
                          } else{
                        AppDialogs.showWarning(context);
                  };
                },
              );
                  }
                  )
              /*: CustomButton(
              text: 'Añadir',
              buttonColor: AppColors.grey,
              onPressed: (){
                AppDialogs.showWarning(context);
              }),*/
              //tasksRepoProvider
              //
              //const LogoutComponent(),
            ],
          ),
        ),
      ),
    );
  }

  bool checkDatosAll(
      String name, String days, String begin, String end, int numRepetition) {
    bool check = false;
    log('**** ' + name + days + begin + end + numRepetition.toString());

    //dias
    if (name != '' &&
        days.isNotEmpty &&
        begin != '' &&
        end != '' &&
        numRepetition != 0) {
      check = true;
    }
    return check;
  }


}
