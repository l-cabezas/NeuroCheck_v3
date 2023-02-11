
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/use_cases/use_case_base.dart';
import '../../data/repos/home_repo.dart';
import '../../presentation/utils/enums.dart';
import '../repos/i_home_repo.dart';

part 'update_task_status_uc.g.dart';

@Riverpod(keepAlive: true)
UpdateTaskStatusUC updateTaskStatusUC(UpdateTaskStatusUCRef ref) {
  return UpdateTaskStatusUC(
    ref,
    homeRepo: ref.watch(homeRepoProvider),
  );
}

class UpdateTaskStatusUC
    implements UseCaseBase<void, UpdateTaskStatusParams> {
  UpdateTaskStatusUC(this.ref, {required this.homeRepo});

  final UpdateTaskStatusUCRef ref;
  final IHomeRepo homeRepo;

  @override
  Future<void> call(UpdateTaskStatusParams params) async {
    return await homeRepo.updateTask(params);
  }
}

class UpdateTaskStatusParams extends Equatable {
  final String taskId;
  final EstadoTarea estadoTarea;


  const UpdateTaskStatusParams({
    required this.taskId,
    required this.estadoTarea,
  });

  Map<String, dynamic> toMap() {
    return {
      'estadoTarea' : estadoTarea.name
    };
  }

  @override
  List<Object> get props => [taskId, estadoTarea];
}
