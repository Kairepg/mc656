import 'package:flutter/material.dart';
import 'package:flutter_application_mc656/pages/home/home_page.dart';
import 'package:flutter_application_mc656/pages/login/login_page.dart';
import 'package:flutter_application_mc656/utils/constants.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
}

// Função para gerar as rotas do aplicativo
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => const MyHomePage(title: Constants.appName,));
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginPage());

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
