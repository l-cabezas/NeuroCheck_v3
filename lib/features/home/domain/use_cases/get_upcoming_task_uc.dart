import 'package:neurocheck/features/home/data/models/task_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/use_cases/use_case_base.dart';
import '../../data/repos/home_repo.dart';
import '../repos/i_home_repo.dart';

part 'get_upcoming_task_uc.g.dart';

@Riverpod(keepAlive: true)
GetUpcomingTaskUC getUpcomingTaskUC(GetUpcomingTaskUCRef ref) {
  return GetUpcomingTaskUC(
    ref,
    homeRepo: ref.watch(homeRepoProvider),
  );
}

class GetUpcomingTaskUC implements UseCaseNoParamsBase<Stream<List<TaskModel>>> {

  GetUpcomingTaskUC(this.ref, {required this.homeRepo});

  final GetUpcomingTaskUCRef ref;
  final IHomeRepo homeRepo;

  @override
  Stream<List<TaskModel>> call() {
    return homeRepo.getUpcomingTaskStream();
  }
}