import 'package:flutter/material.dart';
import 'package:while_app/utils/routes/routes_name.dart';
import 'package:while_app/view/auth/forgot_password_screen.dart';
import 'package:while_app/view/home_screen.dart';
import 'package:while_app/view/auth/register_screen.dart';
import 'package:while_app/view/splash_view.dart';
import 'package:while_app/view_model/wrapper/wrapper.dart';
import '../../view/auth/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
             case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
            case RoutesName.splash:
       return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
            case RoutesName.wrapper:
       return MaterialPageRoute(
            builder: (BuildContext context) => const Wrapper());
             case RoutesName.forgot:
       return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
