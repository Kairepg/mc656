import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_buddy/pages/login/login_page.dart';
import 'package:fitness_buddy/pages/signUp/sign_up_page.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:fitness_buddy/services/firebase_options.dart';
import 'package:fitness_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF56606)),
        primaryColor: const Color(0xFFF56606) ,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: generateRoute,
      home: const LoginPage(),
    );
  }
}

