import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/presentation/utils/functional.dart';
import 'package:neurocheck/features/home/presentation/providers/update_task_status_provider/update_task_status_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/use_cases/update_task_status_uc.dart';

part 'update_task_status_provider.g.dart';

@riverpod
AsyncValue<UpdateTaskStatusState> updateTaskStatusState(UpdateTaskStatusStateRef ref) {
  ref.listenSelf((previous, next) {
    next.whenOrNull(
      error: (_, __) => ref.invalidate(updateTaskStatusParamsProvider),
      data: (state) {
        state.mapOrNull(
          success: (_) => ref.invalidate(updateTaskStatusParamsProvider),
        );
      },
    );
  });

  final params = ref.watch(updateTaskStatusParamsProvider);
  return params.match(
        () => const AsyncData(UpdateTaskStatusState.initial()),
        (params) => ref.watch(updateTaskStatusProvider(params)),
  );
}

final updateTaskStatusParamsProvider =
StateProvider.autoDispose<Option<UpdateTaskStatusParams>>((ref) {
  return const None();
});

@riverpod
Future<UpdateTaskStatusState> updateTaskStatus(
    UpdateTaskStatusRef ref,
    UpdateTaskStatusParams params,
    ) async {
  await ref.watch(updateTaskStatusUCProvider).call(params);
  return UpdateTaskStatusState.success(
    taskId: params.taskId,
    taskStatus: params.estadoTarea,
  );
}
