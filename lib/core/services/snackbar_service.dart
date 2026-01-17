import 'package:flutter/material.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/ui/common/app_sizes.dart';

class SnackBarService {
  void showSnackBar({
    required String message,
    IconData? icon,
    Color? iconColor,
  }) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).hintColor,
      elevation: 3,
      width: AppSizes.screenWidth(context)/1.5,
      content: Center(
        child: Text(message,style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,maxLines: 5, textAlign: TextAlign.center),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
