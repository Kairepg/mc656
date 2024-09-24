import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class ChangeNotifications extends ProfilePage {
  const ChangeNotifications({super.key});

  @override
  State<ChangeNotifications> createState() => _ChangeNotificationsState();
}

class _ChangeNotificationsState extends State<ChangeNotifications> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Notificações',
            ),
          ),
      ), 
    ]);
  }
}
