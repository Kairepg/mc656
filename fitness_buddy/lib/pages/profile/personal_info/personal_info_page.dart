import 'package:cloud_firestore/cloud_firestore.dart';
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
  String emailId = '';

  @override
  void initState() {
    final user = _auth.currentUser;
    if (user != null) {
      emailId = user.email ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();

    return StreamBuilder(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          final data = userDoc.data() as Map<String, dynamic>;

          Text displayBirth = const Text("Não informado.");
          Text displayHeight = const Text("Não informado.");
          if ((data['birth']) != null) {
            displayBirth = data['birth'];
          }
          if ((data['height']) != null) {
            displayHeight = data['height'];
          }

          if (snapshot.hasData) {
            return Column(children: [
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
                  textColor: Theme.of(context).primaryColor)
            ]);
          }
          return const Text("Loading");
        });
  }
}

class PersonalInfoChange extends MenuNavigatorPage {
  const PersonalInfoChange({super.key});

  @override
  State<PersonalInfoChange> createState() => _PersonalInfoChangeState();
}

class _PersonalInfoChangeState extends State<PersonalInfoChange> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _hieghtController = TextEditingController();
  String emailId = '';

  @override
  void initState() {
    final user = _auth.currentUser;
    if (user != null) {
      emailId = user.email ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();

    return StreamBuilder(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          final data = userDoc.data() as Map<String, dynamic>;

          String? displayBirth;
          String? displayHeight;
          if ((data['birth']) != null) {
            displayBirth = data['birth'];
          }
          if ((data['height']) != null) {
            displayHeight = data['height'];
          }

          if (snapshot.hasData) {
            return Column(children: [
              const Icon(Icons.account_circle, size: 100),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: TextFormField(
                  initialValue: data['name'],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  onChanged: (name) {
                      setState(() {
                        _nameController.text = name;
                      });
                  },
                  validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu nome';
                        }
                        return null;
                  }
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: TextFormField(
                  initialValue: displayBirth,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Data de Nascimento',
                  ),
                  onChanged: (birth) {
                      setState(() {
                        _birthController.text = birth;
                      });
                  },
                  validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu nome';
                        }
                        return null;
                  }
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: TextFormField(
                  initialValue: displayHeight,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Altura',
                  ),
                  onChanged: (height) {
                      setState(() {
                        _hieghtController.text = height;
                      });
                  }
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
          }return const Text("Loading");
        });
  }
}
