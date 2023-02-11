
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/app_notification.dart';

final tappedNotificationProvider =
    StateProvider<Option<AppNotification>>((ref) {
  return const None();
});
