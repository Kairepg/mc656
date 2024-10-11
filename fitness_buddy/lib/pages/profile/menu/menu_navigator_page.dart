import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/material.dart';

class MenuNavigatorPage extends StatefulWidget {
  // Contexto das rotas maiores
  final BuildContext? contextRotasTema;

  const MenuNavigatorPage({super.key, this.contextRotasTema});

  @override
  State<MenuNavigatorPage> createState() => _MenuNavigatorPageState();
}

class _MenuNavigatorPageState extends State<MenuNavigatorPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/accountInfoView');
        },
        text: 'Informações da conta',
      ),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/personalInfoView');
        },
        text: 'Informações pessoais',
      ),
      //TODO
      // CardButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/changeNotifications');
      //   },
      //   text: 'Ativar notificações',
      // ),
      // CardButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/deleteAccount');
      //   },
      //   text: 'Excluir conta',
      // ),
      CardButton(
        onPressed: () {
          _auth.signOut();
          Navigator.pushReplacementNamed(widget.contextRotasTema!, AppRoutes.login);
        },
        text: 'Logout',
      ),
    ]);
  }
}
