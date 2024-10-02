import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/pages/profile/personal_info/personal_info_view.dart';
import 'package:flutter/material.dart';

class PersonalInfoView extends MenuNavigatorPage {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}


class _PersonalInfoViewState extends State<PersonalInfoView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    String emailId = '';

    if (user != null) {
      emailId = user.email ?? '';
    }

    Widget nameDisplay = getUserName(emailId);
    Widget birthDisplay = getUserBirth(emailId);
    Widget heightDisplay = getUserHeight(emailId);

    return Column(children: [
      DisplayCard(
        text: nameDisplay,
        subtitle: "Nome:",
        showIcon: false,
      ),
      DisplayCard(
        text: birthDisplay,
        subtitle: "Data de Nascimento:",
        showIcon: false,
      ),
      DisplayCard(
        text: heightDisplay,
        subtitle: "Altura:",
        showIcon: false,
      ),
      const SizedBox(height: 30),
      BtnFilled(
        text: "Alterar dados",
        onPressed: () {
          Navigator.pushNamed(context, '/personalInfoChange');
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


class PersonalInfoChange extends MenuNavigatorPage {
  const PersonalInfoChange({super.key});

  @override
  State<PersonalInfoChange> createState() => _PersonalInfoChangeState();
}

class _PersonalInfoChangeState extends State<PersonalInfoChange> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nome',
            ),
          ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Data de Nascimento',
            ),
          ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Altura',
            ),
          ),
      ),  
      const SizedBox(height: 30),
      BtnFilled(
          text: "Voltar",
          onPressed: () {
            Navigator.pushNamed(context, '/personalInfoView');
          },
          backgroundColor: Colors.white,
          textColor: Theme.of(context).primaryColor)
    ]);
  }
}
