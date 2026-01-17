import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tasky/ui/common/app_colours.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.noBackground = false, required this.child, required this.loading, this.hasMessage = false, this.message,});
  final Widget child;
  final bool loading;
  final bool hasMessage;
  final bool noBackground;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(loading) Positioned.fill(child: Container(
          color: noBackground ? AppColours.transparentColor : AppColours.blackColor.withAlpha((0.5 * 255).toInt()),
          child: !hasMessage ? Center(
            child: LoadingAnimationWidget.fourRotatingDots(color: AppColours.greenColor, size: 80),
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 15,
              children: [
                LoadingAnimationWidget.fourRotatingDots(color: AppColours.greenColor, size: 80),
                if(message != null) Text('$message', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: noBackground ? AppColours.greenColor : AppColours.whiteColor),),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
