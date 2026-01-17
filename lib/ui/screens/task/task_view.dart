import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/app/config/routes.dart';
import 'package:tasky/core/blocs/task_bloc/task_bloc.dart';
import 'package:tasky/core/models/task.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/core/services/snackbar_service.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';
import 'package:tasky/ui/custom_widgets/circular_tile.dart';
import 'package:tasky/ui/custom_widgets/loading_indicator.dart';
import 'package:tasky/ui/custom_widgets/tasky_dialog.dart';
import 'package:tasky/ui/screens/task/task_widget/date_display_tile.dart';
import 'package:tasky/utils/date_time_format.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, required this.task});
  static const String id = Routes.taskView;

  final Task task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isTaskCompleted = false;

  @override
  void initState() {
    isTaskCompleted = widget.task.completed;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state){
        if(state.editStatus == TaskStatus.success){
          _snackBarService.showSnackBar(message: state.successMessage!);
        }
        else if(state.editStatus == TaskStatus.failure){
          _snackBarService.showSnackBar(message: state.errorMessage!);
        }
        else if(state.deleteStatus == TaskStatus.success){
          _navigationService.pop();
          _snackBarService.showSnackBar(message: state.successMessage!);
        }
        else if(state.deleteStatus == TaskStatus.failure){
          _snackBarService.showSnackBar(message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        final updatedTask = state.tasks.firstWhere((task) => task.id == widget.task.id,
          orElse: () => widget.task
        );
        return LoadingIndicator(
          loading: state.editStatus == TaskStatus.loading || state.deleteStatus == TaskStatus.loading,
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: AppSizes.defaultPadding, right: AppSizes.defaultPadding, top: AppSizes.defaultPadding),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularTile(icon: Icons.delete_outline_rounded,
                          color: AppColours.redColor,
                          onTap: (){
                          showDialog(context: context, builder: (context){
                            return TaskyDialog(title: AppStrings.deleteTask,
                                noChild: true,
                                onDone: (){
                              context.read<TaskBloc>().add(DeleteTask(taskId: widget.task.id!));
                              _navigationService.pop();
                                },
                            );
                          });
                        },),
                        Text(AppStrings.task,style: Theme.of(context).textTheme.headlineLarge,),
                        CircularTile(
                          icon: Icons.edit_note_rounded,
                          onTap: (){
                          showDialog(context: context, builder: (context){
                            _titleController.text = updatedTask.title;
                            _descriptionController.text = updatedTask.description;
                            isTaskCompleted = updatedTask.completed;
                            return TaskyDialog(
                                title: AppStrings.editTask,
                                showToggleTaskCompletion: true,
                                isTaskCompleted: isTaskCompleted,
                                onChanged: (value){
                                  isTaskCompleted = value!;
                                  setState(() {});
                                },
                                onDone: (){
                              final task = Task(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  completed: isTaskCompleted,
                                  updatedAt: DateTime.now(),
                                  createdAt: widget.task.createdAt,
                                  userId: widget.task.userId,
                                  id: widget.task.id
                              );
                              context.read<TaskBloc>().add(EditTask(task: task));
                              _navigationService.pop();
                                },
                                titleController: _titleController,
                                descriptionController: _descriptionController
                            );
                          });
                        },),
                      ],
                    ),
                    const SizedBox(height: AppSizes.space15),
                    Text(
                      updatedTask.title,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(color: AppColours.grey300Color,),
                    SizedBox(height: AppSizes.space8,),
                    Text(
                      updatedTask.description,
                      maxLines: 20,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: AppSizes.space8,),
                    Text(
                      !updatedTask.completed ? AppStrings.notCompleted : AppStrings.completed,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: !updatedTask.completed ? AppColours.redColor : AppColours.greenColor),
                    ),
                    SizedBox(height: AppSizes.space8,),
                    DateDisplayTile(
                      text: AppStrings.lastUpdated,
                      date: formatTimeStamp(updatedTask.updatedAt!),
                    ),
                    const SizedBox(height: AppSizes.space5),
                    DateDisplayTile(
                      text: AppStrings.createdAt,
                      date: formatTimeStamp(updatedTask.createdAt!),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
