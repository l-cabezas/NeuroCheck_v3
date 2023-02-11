import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

class CustomTimeRanger extends Container {

  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;


  CustomTimeRanger(       {
      Key?key,
    TimeRangeResult? timeRange,
    TimeRangeResult? defaultTimeRange, required BuildContext context,})
      :super(
      key: key,
      child:
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: leftPadding),
              child: Text(
                'Opening Times',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, color: dark),
              ),
            ),
            SizedBox(height: 20),
            TimeRange(
              fromTitle: Text(
                'FROM',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              toTitle: Text(
                'TO',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              titlePadding: leftPadding,
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: dark,
              ),
              activeTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: orange,
              ),
              borderColor: dark,
              activeBorderColor: dark,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: dark,
              firstTime: TimeOfDay(hour: 0, minute: 00),
              lastTime: TimeOfDay(hour: 23, minute: 59),
              initialRange: timeRange,
              timeStep: 5,
              timeBlock: 5,
              onRangeCompleted: (range) => timeRange = range,
            ),
            SizedBox(height: 30),
            if (timeRange != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Selected Range: ${timeRange!.start.format(context)} - ${timeRange!.end.format(context)}',
                      style: TextStyle(fontSize: 20, color: dark),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      child: Text('Default'),
                      onPressed: ()  {
                        //timeRange = defaultTimeRange;
                        //log('press default');
                        //log(timeRange!.start.format(context));
                        },
                      color: orange,
                    )
                  ],
                ),
              ),
          ],
        ),
      ));
}