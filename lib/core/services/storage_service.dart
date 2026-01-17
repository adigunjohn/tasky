import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/app/theme/saved_theme.dart';
import 'package:tasky/core/models/task.dart';
import 'package:tasky/core/models/user.dart';
import 'package:tasky/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class StorageService{
  static Future<void> initializeHive()async {
    await Hive.initFlutter();
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<ThemeMode>(AppConstants.themeKey);
    await Hive.openBox<bool>(AppConstants.loggedInKey);
    await Hive.openBox<User?>(AppConstants.userKey);
    await Hive.openBox<Task>(AppConstants.tasksKey);
    log('${AppConstants.storageServiceLog}hive successfully initialized');
  }

  void logInfo(String info){
    log('${AppConstants.storageServiceLog}$info');
  }

  ///Boxes
   Box<ThemeMode> themeBox = Hive.box(AppConstants.themeKey);
   Box<bool> loggedInBox = Hive.box(AppConstants.loggedInKey);
   Box<User?> userBox = Hive.box(AppConstants.userKey);
   Box<Task> tasksBox = Hive.box(AppConstants.tasksKey);


  ///For Theme
    ThemeMode? getThemeModeFromHive() => themeBox.get(AppConstants.themeKey, defaultValue: ThemeMode.light);

  Future<void> updateThemeModeToHive({required ThemeMode theme}) async {
      await themeBox.put(AppConstants.themeKey, theme);
      logInfo('theme mode updated to $theme');
  }

  Future<void> clearThemeSettingsInHive() async {
      await themeBox.clear();
      logInfo('Theme box has been cleared');
  }



  ///For LoggedIn
  bool? getLoggedInFromHive() => loggedInBox.get(AppConstants.loggedInKey, defaultValue: false);

  Future<void> updateLoggedInToHive({required bool loggedIn}) async {
      await loggedInBox.put(AppConstants.loggedInKey, loggedIn);
      logInfo('loggedIn updated to $loggedIn');
  }

  Future<void> clearLoggedInHive() async {
      await loggedInBox.clear();
      logInfo('loggedIn box has been cleared');
  }



  ///For User
  User? getUserFromHive() => userBox.get(AppConstants.userKey);

  Future<void> updateUserToHive({required User user}) async {
    await userBox.put(AppConstants.userKey, user);
    logInfo('User updated to $user');
  }

  Future<void> clearUserInHive() async {
    await userBox.clear();
    logInfo('user box has been cleared');
  }



  ///For Tasks
  Future<void> addTasksToHive(List<Task> tasks) async {
    await tasksBox.clear();
    for (var task in tasks) {
      await tasksBox.add(task);
    }
    logInfo('Tasks saved successfully!');
  }

  List<Task>? getTasksFromHive() {
    return tasksBox.values.toList();
  }

  Future<void> clearTasksInHive() async {
    await tasksBox.clear();
    logInfo('tasks box has been cleared');
  }


  static Future<void> closeHive() async {
        await Hive.close();
        log('${AppConstants.storageServiceLog}All opened local storage boxes have been closed');
  }


  ///Flutter Secure Storage to store token
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await secureStorage.write(
      key: AppConstants.authTokenKey,
      value: token,
    );
    logInfo('token stored successfully');
  }

  Future<String?> getToken() async {
    String? token = await secureStorage.read(key: AppConstants.authTokenKey);
    if(token != null) logInfo('token retrieved successfully');
    return token;
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: AppConstants.authTokenKey);
    logInfo('token deleted successfully');
  }

}
