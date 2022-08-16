import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';

import '../models/noti_model.dart';

// selectedOrderProvider

final selectedNotiProvider = StateProvider<TaskModel?>((ref) => null);
//final selectedPlaceGeoPointProvider = StateProvider<GeoPoint?>((ref) => null);
