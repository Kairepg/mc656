import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/account_info/account_info_view.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:flutter/material.dart';

class AccountInfoView extends MenuNavigatorPage {
  const AccountInfoView({super.key});

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  bool _isHidden = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    String emailId = '';

    if (user != null) {
      emailId = user.email ?? '';
    }

    Widget nameDisplay = getUserName(emailId);
    Widget emailDisplay = Text(emailId);
    Widget passwordDisplay = getUserPassword(emailId);

    Widget visibility = IconButton(
      onPressed: _togglePasswordView,
      icon: Icon(
        _isHidden
            ?

            /// CHeck Show & Hide.
            Icons.visibility
            : Icons.visibility_off,
      ),
    );

    return Column(children: [
      DisplayCard(
        text: nameDisplay,
        subtitle: "Nome:",
        showIcon: false,
      ),
      DisplayCard(
        text: emailDisplay,
        subtitle: "Email:",
        showIcon: false,
      ),
      DisplayCard(
          text: _isHidden ? passwordDisplay : const Text("********"),
          subtitle: "Senha:",
          showIcon: true,
          icon: visibility),
      const SizedBox(height: 30),
      BtnFilled(
        text: "Alterar dados",
        onPressed: () {
          Navigator.pushNamed(context, '/accountInfoChange');
        },
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
      ),
      const SizedBox(height: 30),
      BtnFilled(
          text: "Voltar",
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          backgroundColor: Colors.white,
          textColor: Theme.of(context).primaryColor)
    ]);
  }
}

class AccountInfoChange extends MenuNavigatorPage {
  const AccountInfoChange({super.key});

  @override
  State<AccountInfoChange> createState() => _AccountInfoChangeState();
}

class _AccountInfoChangeState extends State<AccountInfoChange> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'E-mail',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Senha',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Conta Privada',
          ),
        ),
      ),
      const SizedBox(height: 30),
      BtnFilled(
          text: "Voltar",
          onPressed: () {
            Navigator.pushNamed(context, '/accountInfoView');
          },
          backgroundColor: Colors.white,
          textColor: Theme.of(context).primaryColor)
    ]);
  }
}
