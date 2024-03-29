import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/features/tasks/presentation/providers/toggle_theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/presentation/screens/popup_page.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/app_colors.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/dialogs.dart';
import '../components/cardMod_item_component.dart';
import '../providers/switch_theme_provider.dart';
import '../components/toggle_choice_component.dart';
import '../../data/models/task_model.dart';

class ModTaskComponent extends HookConsumerWidget {
  const ModTaskComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    GetStorage().write('screen', 'mod');

    var toggleValue = ref.watch(toggleButtonProvider.notifier);
    var choice = 0;
//todo: info icon
    return PopUpPage(
        body: SingleChildScrollView(
            child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Theme.of(context).iconTheme.color ==
                            AppColors.lightThemeIconColor
                            ? AppColors.lightBlack
                            : AppColors.white,
                      )),
                ),
                  Container(
                    padding: EdgeInsets.only(
                      top: Sizes.hMarginMedium(context),
                      bottom: Sizes.vMarginSmallest(context),
                      left: Sizes.vMarginSmallest(context),
                      right: Sizes.vMarginSmallest(context),
                    ),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          AppDialogs.showInfo(context,
                              message: tr(context).info_mod);
                        },
                        icon: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).iconTheme.color ==
                              AppColors.lightThemeIconColor
                              ? AppColors.lightBlack
                              : AppColors.white,
                        )),
                  ),
                ]

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
                            [
                              Theme.of(context).iconTheme.color ==
                                      AppColors.lightThemeIconColor
                                  ? AppColors.accentColorLight
                                  : AppColors.darkThemePrimary,
                            ],
                            [
                              Theme.of(context).iconTheme.color ==
                                      AppColors.lightThemeIconColor
                                  ? AppColors.accentColorLight
                                  : AppColors.darkThemePrimary,
                            ],
                            [
                              Theme.of(context).iconTheme.color ==
                                      AppColors.lightThemeIconColor
                                  ? AppColors.accentColorLight
                                  : AppColors.darkThemePrimary,
                            ]
                          ],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.black12,
                          inactiveFgColor: Theme.of(context).iconTheme.color ==
                                  AppColors.lightThemeIconColor
                              ? AppColors.lightBlack
                              : AppColors.white,
                          initialLabelIndex: toggleValue.state,
                          totalSwitches: 3,
                          radiusStyle: true,
                          labels: ['Días', 'Rango', 'Repetición'],
                          //animate: true,
                          onToggle: (index) {
                            //print('switched to: $index');
                            choice = index!;
                            //print('choice to: $choice');

                            ref
                                .watch(toggleButtonProviderAdd.notifier)
                                .changeState(change: index);
                            toggleValue.state =
                                ref.read(toggleButtonProviderAdd.notifier).state;
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

  Widget getSwitchWidget(bool switchButton, SwitchButton ref) {
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

  List<String> separateString(String string) {
    String delete = string.replaceAll('[', '');
    String delete2 = delete.replaceAll(']', '');
    var split = string.split(',');
    return split;
  }
}
