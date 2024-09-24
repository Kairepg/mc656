import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/accountInfo');
        },
        text: 'Informações da conta',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/personalInfo');
        },
        text: 'Informações pessoais',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/changeNotifications');
        },
        text: 'Ativar notificações',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/deleteAccount');
        },
        text: 'Excluir conta',
      ),
      CardButton(
        onPressed: () {
          _auth.signOut();
          Navigator.pushNamed(context, '/logoff');
        },
        text: 'Logout',
      ),
    ]);
  }
}
