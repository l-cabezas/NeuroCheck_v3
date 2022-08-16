import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/simple_notifications/utilities.dart';


Future<void> createTaskToDoNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
      'Oye haz esto!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      //bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigText,
    ),
  );
}

Future<int> createReminderNotification(
    int day, int hour, int minute) async {
  int idNotification = createUniqueId();
  log('notifications' + day.toString() + hour.toString() + minute.toString());
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
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      //repeats: true,
    ),
  );
  return idNotification;
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduledNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}
