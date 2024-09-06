import 'package:flutter/material.dart';
import 'package:flutter_application_mc656/pages/home/home_page.dart';
import 'package:flutter_application_mc656/routes/routes.dart';
import 'package:flutter_application_mc656/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: generateRoute,
      home: const MyHomePage(title: Constants.appName),
    );
  }
}

