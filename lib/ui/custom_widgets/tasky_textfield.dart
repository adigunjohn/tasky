import 'package:flutter/material.dart';
import 'package:tasky/ui/common/app_colours.dart';

class TaskyTextField extends StatelessWidget {
  const TaskyTextField({super.key, this.textCapitalization , this.alignLabelWithHint, this.minLines, this.labelText, this.filled, required this.controller, this.validator, this.filledColor, this.hintText, this.maxLines, this.obscureText = false, this.keyboardType, this.autoValidateMode, this.suffix,});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color? filledColor;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  final AutovalidateMode? autoValidateMode;
  final Widget? suffix;
  final bool? filled;
  final bool? alignLabelWithHint;
  final TextCapitalization? textCapitalization;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      keyboardType: keyboardType ?? TextInputType.text,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: AppColours.greenColor,
      obscureText: obscureText,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColours.redColor),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        filled: filled ?? true,
        fillColor: filledColor ?? Theme.of(context).hintColor,
        hintText: hintText ?? '',
        labelText: labelText,
        alignLabelWithHint: alignLabelWithHint,
        labelStyle: Theme.of(context).textTheme.displayMedium,
        hintStyle: Theme.of(context).textTheme.displayMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: labelText != null ? BorderSide(color: AppColours.grey400Color, width: 1) : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: labelText != null ? BorderSide(color: AppColours.grey400Color, width: 1) : BorderSide.none,
        ),
      ),
    );
  }
}
