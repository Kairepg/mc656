import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:flutter/material.dart';

class PersonalInfoViewPage extends MenuNavigatorPage {
  final FirebaseAuth? firebaseAuth;
  final FirebaseFirestore? firebaseInstance;
  const PersonalInfoViewPage({
    super.key,
    this.firebaseAuth,
    this.firebaseInstance,
  });

  @override
  State<PersonalInfoViewPage> createState() => _PersonalInfoViewPageState();
}

class _PersonalInfoViewPageState extends State<PersonalInfoViewPage> {
  FirebaseAuth? _auth;
  FirebaseFirestore? users;
  String emailId = '';

  @override
  void initState() {
    if (widget.firebaseAuth != null) {
      _auth = widget.firebaseAuth!;
    } else {
      _auth = FirebaseAuth.instance;
    }

    if (widget.firebaseInstance != null) {
      users = widget.firebaseInstance!;
    } else {
      users = FirebaseFirestore.instance;
    }
    final user = _auth!.currentUser;
    if (user != null) {
      emailId = user.email ?? '';
    }
    super.initState();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() {
    return users!.collection('users').doc(emailId).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _getUserData(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Text("Erro ao carregar dados.");
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text("Dados não encontrados.");
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        Text displayBirth = const Text("Não informado.");
        Text displayHeight = const Text("Não informado.");

        if (data['birth'] != null) {
          displayBirth = Text(data['birth']);
        }
        if (data['height'] != null) {
          displayHeight = Text(data['height']);
        }

        return Column(
          children: [
            DisplayCard(
              text: Text(data['name']),
              subtitle: "Nome:",
              showIcon: false,
            ),
            DisplayCard(
              text: displayBirth,
              subtitle: "Data de Nascimento:",
              showIcon: false,
            ),
            DisplayCard(
              text: displayHeight,
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
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }
}