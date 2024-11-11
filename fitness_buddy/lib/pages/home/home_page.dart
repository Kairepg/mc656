import 'package:fitness_buddy/services/permissions.dart';
import 'package:fitness_buddy/services/push_notification_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    PushNotificationService pushNotificationService = PushNotificationService();
    PermissionsMethods().askNotificationPermission();
    pushNotificationService.getFirebaseToken();
    pushNotificationService.startListeningForNewNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}
