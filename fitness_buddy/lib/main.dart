import 'package:fitness_buddy/pages/home/home_page.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:fitness_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // firebase initialization
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // run the app
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

