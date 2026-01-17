import 'package:flutter/material.dart';
import 'package:tasky/core/models/task.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';
import 'package:tasky/utils/date_time_format.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.onTap, required this.task});
  final VoidCallback onTap;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColours.grey300Color, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSizes.space8,),
            Text(
              task.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: AppSizes.space8,),
            Text(
              !task.completed ? AppStrings.notCompleted : AppStrings.completed,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(color: !task.completed ? AppColours.redColor : AppColours.greenColor),
            ),
            SizedBox(height: AppSizes.space5,),
            Text(
              formatTimeStamp(task.updatedAt!),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        )
      ),
    );
  }
}
