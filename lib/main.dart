import 'package:flutter/material.dart';
import 'package:tasky/app/config/application.dart';
import 'package:tasky/app/config/routes.dart';
import 'package:tasky/app/theme/theme.dart';
import 'package:tasky/core/blocs/task_bloc/task_bloc.dart';
import 'package:tasky/core/blocs/theme_bloc/theme_bloc.dart';
import 'package:tasky/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/ui/screens/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/utils/constants.dart';

Future<void> main() async{
  await Application.initializeApp();
  runApp(const Tasky());
}

class Tasky extends StatelessWidget {
  const Tasky({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(LoadUser())),
        BlocProvider(create: (context) => TaskBloc()),
        BlocProvider(create: (context) => ThemeBloc()..add(LoadSavedTheme())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppConstants.tasky,
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: (settings) => Routes.generateRoute(settings),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: const SplashView(),
          );
        }
      ),
    );
  }
}

