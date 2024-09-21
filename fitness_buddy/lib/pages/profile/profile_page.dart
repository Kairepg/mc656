import 'package:fitness_buddy/pages/profile/profile_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          Navigator.pushNamed(context, AppRoutes.login);
        },
        text: 'Logout',
      ),
    ]);
  }
}
