import 'package:fitness_buddy/pages/auth/login/login_page.dart';
import 'package:fitness_buddy/pages/auth/onboarding/onboarding_page.dart';
import 'package:fitness_buddy/pages/auth/signUp/sign_up_page.dart';
import 'package:fitness_buddy/pages/page_manager.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String favorite = '/home/favorite';
  static const String profile = '/home/profile';
  static const String activity = '/home/activity';
  static const String ranking = '/home/ranking';
}

// Função para gerar as rotas do aplicativo
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    case AppRoutes.onboarding:
      return MaterialPageRoute(builder: (context) => OnboardingPage());
    case AppRoutes.home:
      return MaterialPageRoute(
          builder: (context) => const PageManager(initialPage: 0));
    case AppRoutes.favorite:
      return MaterialPageRoute(
          builder: (context) => const PageManager(initialPage: 1));
    case AppRoutes.activity:
      return MaterialPageRoute(
          builder: (context) => const PageManager(initialPage: 2));
    case AppRoutes.ranking:
      return MaterialPageRoute(
          builder: (context) => const PageManager(initialPage: 3));
    case AppRoutes.profile:
      return MaterialPageRoute(
          builder: (context) => const PageManager(initialPage: 4));

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
