

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/task_model.dart';
import '../../domain/use_cases/get_upcoming_task_uc.dart';

final changeTaskProvider =
StreamProvider.autoDispose<List<TaskModel>>((ref) {
  final taskssStream = ref.watch(getUpcomingTaskUCProvider).call();
  return taskssStream.distinct((previous, next) {
    //Compare prev,next streams by deep equals and skip if they're not equal,
    //while ignoring deliveryGeoPoint in Order entity's equatable props list.
    //This avoid updating the stream when the delivery updates his own deliveryGeoPoint
    //which will lead to unnecessary api calls.
    return previous.lock == next.lock;
  });
});