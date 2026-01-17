import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/app/config/routes.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/core/services/storage_service.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';
import 'package:tasky/ui/screens/auth/register_view.dart';
import 'package:tasky/ui/screens/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String id = Routes.splashView;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  @override
  void initState() {
    super.initState();
   Future.delayed(Duration(seconds: 4), (){
     final loggedIn = _storageService.getLoggedInFromHive();
     if(loggedIn != null && loggedIn == true){
       _navigationService.replaceNamed(HomeView.id);
     } else {
       _navigationService.replaceNamed(RegisterView.id);
     }
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.task_alt_rounded, color: AppColours.greenColor, size: AppSizes.splashIconSize,).animate().rotate(duration: 700.ms),
            Text(
              AppStrings.tasky,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 3),).animate().fadeIn(delay: 750.ms ,duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
