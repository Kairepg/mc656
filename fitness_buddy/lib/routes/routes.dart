import 'package:fitness_buddy/pages/home/home_page.dart';
import 'package:fitness_buddy/pages/login/login_page.dart';
import 'package:fitness_buddy/pages/signUp/sign_up_page.dart';
import 'package:fitness_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
}

// Função para gerar as rotas do aplicativo
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => const MyHomePage(title: Constants.appName,));
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (context) => const SignUpPage());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Rota não definida: ${settings.name}'),
          ),
        ),
      );
  }
}
