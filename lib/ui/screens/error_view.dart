import 'package:flutter/material.dart';
import 'package:tasky/app/config/routes.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});
 static const String id = Routes.errorView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.space15),
            Center(child: Text(AppStrings.errorTitle, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
            const SizedBox(height: AppSizes.space15),
            Center(
              child: Text(AppStrings.errorText,maxLines: 3,textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
            )
          ],
        ),
      )),
    );
  }
}
