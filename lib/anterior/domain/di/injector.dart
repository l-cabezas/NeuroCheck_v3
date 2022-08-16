import 'package:neurocheck/data/repository/auth/auth_repository_impl.dart';
import 'package:neurocheck/data/firebase_service/firebase_service.dart';
import 'package:neurocheck/domain/users/get_user_uc.dart';

import '../../data/repository/auth/auth_repository.dart';
import '../../presentation/providers/userApp_provider.dart';
import '../../data/repository/tasks/taskRepository.dart';
import '/data/repository/tasks/taskRepositoryImpl.dart';
import '/domain/tasks/get_tasks_uc.dart';
import 'package:get_it/get_it.dart';
import '../../data/firestore_service/firestore_service.dart';
import '../../presentation/providers/task_provider.dart';


final _injector = GetIt.instance;

void setUp() {
  _injector.registerLazySingleton<FirestoreService>(() => FirestoreService());

  _injector.registerLazySingleton<FirebaseService>(() => FirebaseService());

  _injector.registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(_injector<FirestoreService>()));

  _injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(_injector<FirebaseService>()));

  // Providers
  _injector.registerLazySingleton<TaskProvider>(
          () => TaskProvider(_injector<GetTasksUC>()));

  _injector.registerLazySingleton<UserAppProvider>(
          () => UserAppProvider(_injector<GetUserUC>()));


  // Use Cases
  _injector.registerLazySingleton<GetTasksUC>(
          () => GetTasksUC(_injector<TasksRepository>()));

  _injector.registerLazySingleton<GetUserUC>(
          () => GetUserUC(_injector<AuthRepository>()));

}