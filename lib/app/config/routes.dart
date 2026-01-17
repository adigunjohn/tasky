import 'package:flutter/material.dart';
import 'package:tasky/ui/screens/auth/login_view.dart';
import 'package:tasky/ui/screens/auth/register_view.dart';
import 'package:tasky/ui/screens/error_view.dart';
import 'package:tasky/ui/screens/home/home_view.dart';
import 'package:tasky/ui/screens/splash_view.dart';

class Routes {
  //Views
  static const String splashView = '/splash-view';
  static const String errorView = '/error-view';
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String taskView = '/task-view';

  static Route<RouteSettings> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashView.id:
        return MaterialPageRoute(builder: (_) => const SplashView(),);
      case HomeView.id:
        return MaterialPageRoute(builder: (_) => HomeView(),);
      case LoginView.id:
        return MaterialPageRoute(builder: (_) => const LoginView(),);
      case RegisterView.id:
        return MaterialPageRoute(builder: (_) => const RegisterView(),);
      default:
        return MaterialPageRoute(builder: (_) => const ErrorView());
    }
  }
}

