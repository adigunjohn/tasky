part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksFromStorage extends TaskEvent {}

class LoadTasks extends TaskEvent {}


class AddTask extends TaskEvent {
  final Task task;

  const AddTask({required this.task});
  @override
  List<Object> get props => [task];
}


class EditTask extends TaskEvent {
  final Task task;

  const EditTask({required this.task});
  @override
  List<Object> get props => [task];
}


class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask({required this.taskId});
  @override
  List<Object> get props => [taskId];
}


class ClearTasks extends TaskEvent {}