import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/components/toggle_theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/screens/popup_page.dart';
import '../../../core/styles/sizes.dart';
import '../../../features/home/data/models/task_model.dart';
import '../components/cardMod_item_component.dart';
import '../components/forms/days/switch_theme_provider.dart';
import '../components/toggle_choice_component.dart';

class ModTaskComponent extends HookConsumerWidget {
  const ModTaskComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    GetStorage().write('screen','mod');

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
            icon:  Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).colorScheme.primary,
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
                  [Theme.of(context).colorScheme.secondary,],
                  [Theme.of(context).colorScheme.secondary,],
                  [Theme.of(context).colorScheme.secondary,]
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
          activeColor: Colors.white,
          activeTrackColor: Colors.lightBlue,
        );
      },
      cupertino: (_, __) {
        return CupertinoSwitchData(
          activeColor: Colors.lightBlue,
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


