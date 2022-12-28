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
import 'package:neurocheck/modules/tasks/components/toggle_theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../auth/repos/user_repo.dart';
import '../../../core/screens/popup_page.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_app_bar_widget.dart';
import '../../home/components/card_user_details_component.dart';
import '../../navBar/components/card_item_component.dart';
import '../components/cardMod_item_component.dart';
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
import '../components/toggle_choice_component.dart';
import '../models/task_model.dart';
import '../repos/task_repo.dart';

class ModTaskComponent extends HookConsumerWidget {
  const ModTaskComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    var toggleValue = ref.watch(toggleButtonProvider.notifier);
    var choice = 0;
//todo: info icon
    return PopUpPage(
        body: SingleChildScrollView(
            child: Column(
                children: [
      Container(
        padding: EdgeInsets.only(
          top: Sizes.hMarginMedium(context),
          bottom: Sizes.vMarginSmallest(context),
          left: Sizes.vMarginSmallest(context),
        ),
        alignment: Alignment.topLeft,
        child: IconButton(
            onPressed: () {
              ref
                  .watch(toggleButtonProviderAdd.notifier)
                  .changeState(change: 0);
              Navigator.pop(context);

            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: AppColors.lightBlue,
            )),
      ),
      Container(
        padding: EdgeInsets.symmetric(
          //vertical: Sizes.screenVPaddingHigh(context),
          horizontal: Sizes.screenHPaddingDefault(context),
        ),
        child: CardModItemComponent(
          taskModel: taskModel,
        ),
      ),
      SizedBox(
        height: Sizes.vMarginSmall(context),
      ),
      Container(
        child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              ToggleSwitch(
                minWidth: Sizes.availableScreenWidth(context),
                cornerRadius: 20.0,
                activeBgColors: [
                  [AppColors.blue],
                  [AppColors.blue],
                  [AppColors.blue]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.black12,
                inactiveFgColor: Colors.black,
                initialLabelIndex: toggleValue.state,
                totalSwitches: 3,
                radiusStyle: true,
                labels: ['Días', 'Rango', 'Repetición'],
                //animate: true,
                onToggle: (index) {
                  //print('switched to: $index');
                  choice = index!;
                  //print('choice to: $choice');

                  ref .watch(toggleButtonProviderAdd.notifier)
                      .changeState(change: index);
                  toggleValue.state = ref.read(toggleButtonProviderAdd.notifier).state;
                  //switchValue = ref.read(switchButtonProviderAdd.notifier).state;
                },
              ),
              //const ResetFormComponent(),
              ToggleChoiceComponent(
                context: context,
                taskModel: taskModel,
              )
            ]),
      )
    ])));
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


