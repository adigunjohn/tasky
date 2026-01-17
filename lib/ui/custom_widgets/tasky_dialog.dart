import 'package:flutter/material.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';
import 'package:tasky/ui/custom_widgets/tasky_textfield.dart';
import 'package:tasky/utils/input_validator.dart';

class TaskyDialog extends StatefulWidget {
  const TaskyDialog({super.key, this.noChild = false,
    this.isTaskCompleted = false,
    this.showToggleTaskCompletion = false,
    this.onChanged,
    required this.title,
    required this.onDone,
    this.titleController,
    this.descriptionController,
  });

  final String title;
  final VoidCallback onDone;
  final void Function(bool?)? onChanged;
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final bool noChild;
  final bool showToggleTaskCompletion;
  final bool isTaskCompleted;

  @override
  State<TaskyDialog> createState() => _TaskyDialogState();
}

class _TaskyDialogState extends State<TaskyDialog> {
  final _formKey = GlobalKey<FormState>();

  final NavigationService _navigationService = locator<NavigationService>();
  bool completed = false;

  @override
  void initState() {
    completed = widget.isTaskCompleted;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600,),
        overflow: TextOverflow.ellipsis,
      ),
      content: widget.noChild ? null : Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSizes.space5),
            TaskyTextField(
              controller: widget.titleController!,
              hintText: AppStrings.titleHintText,
              textCapitalization: TextCapitalization.sentences,
              validator: InputValidator.validateTaskTitle,
              autoValidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: AppSizes.space15),
            Text(
              AppStrings.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSizes.space5),
            TaskyTextField(
              controller: widget.descriptionController!,
              hintText: AppStrings.descriptionHintText,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              validator: InputValidator.validateTaskDescription,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              minLines: 3,
              maxLines: 3,
            ),
            if(widget.showToggleTaskCompletion) ...[
              const SizedBox(height: AppSizes.space15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSizes.space5,
                children: [
                  Text(
                    '${AppStrings.markAs} ${!widget.isTaskCompleted ? AppStrings.completed : AppStrings.notCompleted}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Checkbox(
                    value: completed,
                    onChanged: (value){
                      setState(() {
                        completed = value!;
                      });
                      widget.onChanged!(value);
                    },
                    side: BorderSide(color: AppColours.greenColor,width: 2),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _navigationService.pop,
            child: Text(AppStrings.cancel, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColours.redColor),)),
        TextButton(onPressed: widget.noChild ? widget.onDone : (){
          if (_formKey.currentState!.validate()) {
            FocusScope.of(context).unfocus();
            widget.onDone();
          }
        }, child: Text(AppStrings.done, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColours.greenColor),)),
      ],
      actionsPadding: EdgeInsets.symmetric(horizontal: AppSizes.padding10, vertical: AppSizes.padding10),
    );
  }
}
