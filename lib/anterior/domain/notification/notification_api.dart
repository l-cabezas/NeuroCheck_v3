
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi{
    static final _notifications=FlutterLocalNotificationsPlugin();
    static final onNotifications = BehaviorSubject<String?>();



 static Future _notificationDetails(String channel) async {

    const sound = 'notification_sound.wav';
    //const a =  sound.split('.').first;
     return  NotificationDetails(
         android: AndroidNotificationDetails(
             channel, //hay que irlo cambiando
             'channel name',
              importance: Importance.max,
             //'channel description',
              playSound: true,
              //sound: RawResourceAndroidNotificationSound('notification_sound'),
             enableVibration: false,
             //styleInformation: ,

         ),
         iOS: const IOSNotificationDetails(
             //presentSound: false,
             sound: 'notification_sound'),
     ); // NotificationDetails

 }

 static Future init({bool initScheduled=false}) async{
     const android =AndroidInitializationSettings('@mipmap/ic_launcher');
     const iOS=IOSInitializationSettings();
     const settings=const InitializationSettings (android: android, iOS: iOS);

     //cuando se cierra la app
     final details = await _notifications.getNotificationAppLaunchDetails();
     if (details != null && details.didNotificationLaunchApp) {
        onNotifications.add(details.payload);
     }
       await _notifications.initialize(settings, onSelectNotification:
           (payload) async {
         onNotifications.add(payload);
     },
     );
     if(initScheduled){
       tz.initializeTimeZones();
       final locationName = await FlutterNativeTimezone.getLocalTimezone();
       tz.setLocalLocation(tz.getLocation(locationName));
     }
 }

 static Future showNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
    }) async =>
     _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(id.toString()),
        payload: payload,
    );

    static Future showScheludeNotification({
      int id=80,
      String? title,
      String? body,
      String? payload,
      required DateTime scheludeDate,
    }) async =>
        _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheludeDate, tz.local),
          await _notificationDetails(id.toString()),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        );

    ///this usamos al añadir tarea
    static Future showScheludeNotificationDailyBasis({
      int? id,
      String? title,
      String? body,
      String? payload,
      required int hora,
      required int minuto,
      required List<int> days,
    }) async =>
        _notifications.zonedSchedule(
          id!,
          title,
          body,
          //horas, minutos segundos
            //en este caso todos los dias a las 8
          //_scheduleDaily(Time(hora,minuto)),
            _scheduleWeeekly(Time(hora,minuto), days:days ),
          await _notificationDetails(id.toString()),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time
        );

    static tz.TZDateTime _scheduleWeeekly(Time time,{required List<int> days}){
      tz.TZDateTime scheduleDate = _scheduleDaily(time);
      while(!days.contains(scheduleDate.weekday)){
        scheduleDate = scheduleDate.add(const Duration(days: 1));
      }
      return scheduleDate;
    }


    static tz.TZDateTime _scheduleDaily(Time time){
      final now = tz.TZDateTime.now(tz.local);
      final scheduleDate = tz.TZDateTime(tz.local,
          now.year,now.month,now.day, time.hour,
      time.minute, 0);
      return scheduleDate.isBefore(now)
          ? scheduleDate.add(const Duration(days: 1))
          : scheduleDate;

    }

    static Future showScheludeNotificationSeconds({
      int? id,
      String? title,
      String? body,
      String? payload,
      int? hora,
      int? minuto,

      required DateTime scheludeDate,
    }) async =>
        _notifications.zonedSchedule(
            id!,
            title,
            body,
            //horas, minutos segundos
            //en este caso todos los dias a las 8
            _scheduleSeconds(),
            await _notificationDetails(id.toString()),
            payload: payload,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time
        );

    static tz.TZDateTime _scheduleSeconds(){
      final now = tz.TZDateTime.now(tz.local);
      final scheduleDate = tz.TZDateTime(tz.local,
          now.year,now.month,now.day, now.hour,
          now.minute, now.second);
      return scheduleDate.isBefore(now)
          ? scheduleDate.add(const Duration(seconds: 2))
          : scheduleDate;

    }

    static Future showScheludeNotificationWeeklyBasis({
      int id=0,
      String? title,
      String? body,
      String? payload,
      required DateTime scheludeDate,
    }) async =>
        _notifications.zonedSchedule(
            id,
            title,
            body,
            //horas, minutos segundos
            //en este caso todos los dias a las 8 si quitamos dias pues eso
            _scheduleWeeekly(const Time(8), days: [DateTime.monday,DateTime.tuesday,DateTime.wednesday,
              DateTime.thursday,DateTime.friday,DateTime.saturday,DateTime.sunday]),
            await _notificationDetails(id.toString()),
            payload: payload,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
        );


    static void cancel(int id) {
      print('cancela $id');
      _notifications.cancel(id);
    }

    static void cancelAll() => _notifications.cancelAll();


}