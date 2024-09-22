import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:fitness_buddy/pages/profile/profile_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends ProfilePage {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.home);
        },
        text: 'Informações da conta',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.home);
        },
        text: 'Informações da pessoais',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.home);
        },
        text: 'Ativar notificações',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.home);
        },
        text: 'Excluir conta',
      ),
      CardButton(
        onPressed: () {
          _auth.signOut();
          Navigator.pushNamed(context, AppRoutes.login);
        },
        text: 'Logout',
      ),
    ]);
  }
}
