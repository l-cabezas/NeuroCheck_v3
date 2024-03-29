import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:neurocheck/core/presentation/styles/app_images.dart';

import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/app_colors.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/cached_network_image_circular.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../tasks/data/models/task_model.dart';

class CardUserDetailsComponent extends StatelessWidget {
  final TaskModel taskModel;

  const CardUserDetailsComponent({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        //Icon(PlatformIcons(context).book),
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(28), // Image radius
            child: Image.asset(
                Theme.of(context).iconTheme.color == AppColors.lightThemeIconColor
                    ? '${AppImages.iconsTask}/iconTask.png'
                    : '${AppImages.iconsTask}/iconTask_dark.png',
                fit: BoxFit.cover
            ),
          ),
        ),

        SizedBox(
          width: Sizes.hMarginSmallest(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.h5(
                context,
                taskModel.taskName.isEmpty
                    ? 'No name'
                    : taskModel.taskName,
                color: Theme.of(context).textTheme.headline4!.color,
                weight: FontStyles.fontWeightBold,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2,),

              CustomText.h6(
                context,
                //'${reformDays(taskModel.days.toString())}',
                reformDays(getDiasString(sortDay(taskModel.days!)).toString()),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2,),

              CustomText.h6(
                context,
                tr(context).hourRange + ' ${taskModel.begin!} - ${taskModel.end!}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2,),

              CustomText.h6(
                context,
                '${tr(context).repTime} ${taskModel.numRepetition!} minutos',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String reformDays(String days){
    var left = days.replaceAll('[','');
    var right = left.replaceAll(']','');
    return right;

  }



  List<dynamic> sortDay(List<dynamic> selectedDia) {
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
      //print(element.toString());
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



}
