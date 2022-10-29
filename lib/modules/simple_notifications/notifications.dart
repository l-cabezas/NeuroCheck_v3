import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/simple_notifications/utilities.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';


Future<int> createTaskToDoNotification(int hour, int minute, String taskName) async {
  int idNotification = createUniqueId();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: idNotification,
      channelKey: 'basic_channel',
      title:
      'Oye haz esto ${taskName}!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      //bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigText,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Hecho',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: DateTime.now().weekday,
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
  return idNotification;
}


Future<int> createReminderNotification( int day, int hour, int minute, String taskName) async {
  int idNotification = createUniqueId();
  //log('notifications' + day.toString() + hour.toString() + minute.toString());
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: idNotification,
      channelKey: 'scheduled_channel',
      title: 'Do ${taskName}',
      body: 'venga va que toca',//'Rango horario ${taskModel.begin} ${taskModel.end}',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Hecho',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: day,
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
  return idNotification;
}

Future<int> reCreateReminderNotification(int day, String hour) async {
  int idNotification = createUniqueId();
  var hs = hour.split(':');
  int h = int.parse(hs[0]);
  int m = int.parse(hs[1]);
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: idNotification,
      channelKey: 'scheduled_channel',
      title: '${Emojis.wheater_droplet} Add some water to your plant!',
      body: 'Water your plant regularly to keep it healthy.',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      weekday: day,
      hour: h,
      minute: m,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
  log('id recreate notification en notification $idNotification');
  return idNotification;
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduledNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}
