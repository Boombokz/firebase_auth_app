import 'package:auth_app_with_firebase/ui/screens/auth/auth_page.dart';
import 'package:auth_app_with_firebase/ui/screens/auth/change_password_page.dart';
import 'package:auth_app_with_firebase/ui/screens/auth/login_page.dart';
import 'package:auth_app_with_firebase/ui/screens/auth/recovery_password_page.dart';
import 'package:auth_app_with_firebase/ui/screens/auth/register_page.dart';
import 'package:auth_app_with_firebase/ui/screens/main_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String authPage = '/';
  static const String loginPage = 'LoginPage';
  static const String registerPage = 'RegisterPage';
  static const String mainPage = 'MainPage';
  static const String recoveryPasswordPage = 'RecoveryPasswordPage';
  static const String changePasswordPage = 'ChangePasswordPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authPage:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case recoveryPasswordPage:
        return MaterialPageRoute(builder: (_) => RecoveryPasswordPage());
      case changePasswordPage:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Страница не существует'),
            ),
          ),
        );
    }
  }
}