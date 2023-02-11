import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neurocheck/features/home/presentation/utils/enums.dart';

part 'update_task_status_state.freezed.dart';

@freezed
class UpdateTaskStatusState with _$UpdateTaskStatusState {
  const factory UpdateTaskStatusState.initial() = _Initial;

  const factory UpdateTaskStatusState.success(
      {required String taskId,
        required EstadoTarea taskStatus}) = _Success;
}