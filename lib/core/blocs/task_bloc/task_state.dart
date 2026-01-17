part of 'task_bloc.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskState extends Equatable {
  final TaskStatus loadStatus;
  final TaskStatus addStatus;
  final TaskStatus deleteStatus;
  final TaskStatus editStatus;
  final List<Task> tasks;
  final String? errorMessage;
  final String? successMessage;

  const TaskState({
    this.loadStatus = TaskStatus.initial,
    this.addStatus = TaskStatus.initial,
    this.deleteStatus = TaskStatus.initial,
    this.editStatus = TaskStatus.initial,
    this.errorMessage,
    this.tasks = const [],
    this.successMessage,
  });

  TaskState copyWith({
    TaskStatus? loadStatus,
    TaskStatus? addStatus,
    TaskStatus? deleteStatus,
    TaskStatus? editStatus,
    List<Task>? tasks,
    String? errorMessage,
    String? successMessage,
  }){
    return TaskState(
      loadStatus: loadStatus ?? this.loadStatus,
      addStatus: addStatus ?? this.addStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      editStatus: editStatus ?? this.editStatus,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage, successMessage, tasks, addStatus, deleteStatus, editStatus];
}

