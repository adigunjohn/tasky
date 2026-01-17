import 'package:get_it/get_it.dart';
import 'package:tasky/core/repositories/auth_repository.dart';
import 'package:tasky/core/repositories/task_repository.dart';
import 'package:tasky/core/repositories/theme_repository.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/core/services/network_service.dart';
import 'package:tasky/core/services/snackbar_service.dart';
import 'package:tasky/core/services/storage_service.dart';


GetIt locator = GetIt.instance;
void setupLocator(){
  //Services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackBarService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => NetworkService());

  //Repos
  locator.registerLazySingleton(() => ThemeRepository());
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => TaskRepository());
}
