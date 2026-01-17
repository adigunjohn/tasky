import 'dart:developer';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/models/task.dart';
import 'package:tasky/core/services/network_service.dart';
import 'package:tasky/core/services/storage_service.dart';
import 'package:tasky/utils/constants.dart';

class TaskRepository {
  final NetworkService _networkService = locator<NetworkService>();
  final StorageService _storageService = locator<StorageService>();

  void logInfo(String info){
    log('${AppConstants.taskRepoLog}$info');
  }



  Future<List<Task>> getTasks() async {
    try{
      logInfo('Getting tasks');
      final token = await _storageService.getToken();
      if(token == null) throw Exception('Token is null');
      final response = await _networkService.get(
          AppConstants.userTasksEndpoint,
          headers: AppConstants.authorizedHeader(token)
      );

      final data = response['items'];
      if(data == null) logInfo('Data is null');
      final taskList = data.map<Task>((json) => Task.fromJson(json)).toList();
      await _storageService.addTasksToHive(taskList);
      return taskList;

    }
    catch(e){
      logInfo('Get tasks failed: $e');
      rethrow;
    }
  }



  Future<void> addTask({required Task task}) async {
    try{
      logInfo('Adding task');
      final token = await _storageService.getToken();
      if(token == null) throw Exception('Token is null');

      await _networkService.post(
          AppConstants.addTaskEndpoint,
          headers: AppConstants.authorizedHeader(token),
          body: task.toJson()
      );

    }
    catch(e){
      logInfo('Add task failed: $e');
      rethrow;
    }
  }



  Future<void> editTask({required Task task}) async {
    try{
      logInfo('Editing task');
      final token = await _storageService.getToken();
      if(token == null) throw Exception('Token is null');

      await _networkService.patch(
          AppConstants.modifyTaskEndpoint(task.id!),
          headers: AppConstants.authorizedHeader(token),
          body: task.toJson()
      );

    }
    catch(e){
      logInfo('Edit task failed: $e');
      rethrow;
    }
  }



  Future<void> deleteTask({required String taskId}) async {
    try{
      logInfo('Deleting task');
      final token = await _storageService.getToken();
      if(token == null) throw Exception('Token is null');

      await _networkService.delete(
          AppConstants.modifyTaskEndpoint(taskId),
          headers: AppConstants.authorizedHeader(token),
      );

    }
    catch(e){
      logInfo('Delete task failed: $e');
      rethrow;
    }
  }

}
