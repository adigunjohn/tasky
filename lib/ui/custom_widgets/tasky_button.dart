import 'package:flutter/material.dart';
import 'package:tasky/ui/common/app_colours.dart';

class TaskyButton extends StatelessWidget {
  const TaskyButton({super.key, required this.onTap,this.text, this.height, this.width, this.textColor});
  final VoidCallback? onTap;
  final String? text;
  final Color? textColor;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColours.greenColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text('$text', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: textColor ?? AppColours.whiteColor),),
        ),
      ),
    );
  }
}
