import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors.dart';

class CustomSelectWeekDays extends Container {
  static List<DayInWeek> days = [
    DayInWeek("Lunes",),
    DayInWeek("Martes",),
    DayInWeek("Miércoles"),
    DayInWeek("Jueves"),
    DayInWeek("Viernes"),
    DayInWeek("Sábado"),
    DayInWeek("Domingo"),
  ];

  static List<DayInWeek> desSelectedDays = [
    DayInWeek("Lunes",isSelected: false),
    DayInWeek("Martes",isSelected: false),
    DayInWeek("Miércoles",isSelected: false),
    DayInWeek("Jueves",isSelected: false),
    DayInWeek("Viernes",isSelected: false),
    DayInWeek("Sábado",isSelected: false),
    DayInWeek("Domingo",isSelected: false),
  ];

  static cleanDays(List<DayInWeek> days){
    days.forEach((element) {
      element.isSelected = false;
    });
  }

  static List<DayInWeek> daysT = [
    DayInWeek(
      "Todos los días",
    ),
  ];

  static String selectdays = '';

  CustomSelectWeekDays({
    Key? key,
  }) : super(
            key: key,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SelectWeekDays(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    days: days,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        // 10% of the width, so there are ten blinds.
                        colors: [
                          AppColors.lightThemePrimary,
                          AppColors.lightThemePrimary
                        ],
                        // whitish to gray
                        tileMode: TileMode
                            .repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    onSelect: (values) {
                      print(values);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SelectWeekDays(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    days: daysT,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        // 10% of the width, so there are ten blinds.
                        colors: [
                          AppColors.lightThemePrimary,
                          AppColors.lightThemePrimary
                        ], // whitish to gray
                        tileMode: TileMode
                            .repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    onSelect: (values) {
                      print(values);
                      days = desSelectedDays;
                    },
                  ),
                  SizedBox(height: 5,),
                ])));
}
