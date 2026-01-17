import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/models/task.dart';
import 'package:tasky/core/repositories/task_repository.dart';
import 'package:tasky/core/services/storage_service.dart';
import 'package:tasky/utils/extensions.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository = locator<TaskRepository>();
  final StorageService _storageService = locator<StorageService>();

  TaskBloc() : super(const TaskState()) {
    on<LoadTasks>(_loadTasks);
    on<ClearTasks>(clearTasks);
    on<LoadTasksFromStorage>(_loadTasksFromStorage);
    on<AddTask>(_addTask);
    on<EditTask>(_editTask);
    on<DeleteTask>(_deleteTask);
  }


  Future<void> _loadTasks(LoadTasks event, Emitter<TaskState> emit) async{
    try{
      emit(state.copyWith(loadStatus: TaskStatus.loading, addStatus: TaskStatus.initial, editStatus: TaskStatus.initial, deleteStatus: TaskStatus.initial));
        final tasks = await _taskRepository.getTasks();
        emit(state.copyWith(loadStatus: TaskStatus.success, tasks: tasks, successMessage: 'Tasks loaded successfully'));
    }
    catch(e){
      emit(state.copyWith(loadStatus: TaskStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  Future<void> _loadTasksFromStorage(LoadTasksFromStorage event, Emitter<TaskState> emit) async{
    try{
      emit(state.copyWith(loadStatus: TaskStatus.loading, addStatus: TaskStatus.initial, editStatus: TaskStatus.initial, deleteStatus: TaskStatus.initial));
      final tasks = _storageService.getTasksFromHive() ?? [];
      if (tasks.isNotEmpty) {emit(state.copyWith(loadStatus: TaskStatus.success, tasks: tasks, successMessage: 'Tasks loaded from storage successfully'));
    } else{
        final tasks = await _taskRepository.getTasks();
        emit(state.copyWith(loadStatus: TaskStatus.success, tasks: tasks));
      }
    }
    catch(e){
      emit(state.copyWith(loadStatus: TaskStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async{
    final previousState = state.tasks;
    try{
      emit(state.copyWith(addStatus: TaskStatus.loading,loadStatus: TaskStatus.initial, editStatus: TaskStatus.initial, deleteStatus: TaskStatus.initial));
      emit(state.copyWith(tasks: [...previousState, event.task]));
      await _taskRepository.addTask(task: event.task);
      emit(state.copyWith(addStatus: TaskStatus.success, successMessage: 'Task added successfully'));
    }
    catch(e){
      emit(state.copyWith(tasks: previousState, addStatus: TaskStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  Future<void> _editTask(EditTask event, Emitter<TaskState> emit) async{
    final previousState = state.tasks;
    try{
      emit(state.copyWith(editStatus: TaskStatus.loading, deleteStatus: TaskStatus.initial, addStatus: TaskStatus.initial, loadStatus: TaskStatus.initial));
      final tasks = List<Task>.from(previousState);
      final index = tasks.indexWhere((e) => e.id == event.task.id);
      tasks[index] = event.task;
      emit(state.copyWith(tasks: tasks));
      await _taskRepository.editTask(task: event.task);
      emit(state.copyWith(editStatus: TaskStatus.success, successMessage: 'Task edited successfully'));
    }
    catch(e){
      emit(state.copyWith(tasks: previousState, editStatus: TaskStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  Future<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async{
    final previousState = state.tasks;
    try{
      emit(state.copyWith(deleteStatus: TaskStatus.loading, editStatus: TaskStatus.initial, addStatus: TaskStatus.initial, loadStatus: TaskStatus.initial));
      final tasks = List<Task>.from(previousState)..removeWhere((e) => e.id == event.taskId);
      emit(state.copyWith(tasks: tasks));
      await _taskRepository.deleteTask(taskId: event.taskId);
      emit(state.copyWith(deleteStatus: TaskStatus.success, successMessage: 'Task deleted successfully'));
    }
    catch(e){
      emit(state.copyWith(tasks: previousState, deleteStatus: TaskStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  void clearTasks(ClearTasks event, Emitter<TaskState> emit){
    emit(const TaskState());
  }
}