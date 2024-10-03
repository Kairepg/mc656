import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
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
            displayBirth = Text(data['birth']);
          }
          if ((data['height']) != null) {
            displayHeight = Text(data['height']);
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
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String emailId = '';

  Future<void> _changePersonalInfo(scaffoldMessenger, documentId) async {
    SnackBar? snackBar;
    final user = _auth.currentUser;

    // ainda nao temos exceções para esse tipo de dados
    // try {

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .update({
        "name": _nameController.text,
        "birth": _birthController.text,
        "height": _heightController.text
      });
    }

    snackBar = SnackBars.usuarioAtualizado();
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     snackBar = SnackBars.senhaFraca();
    //   } else if (e.code == 'email-already-in-use') {
    //     snackBar = SnackBars.emailEmUso();
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());
    //   snackBar = SnackBars.erroAoAtualizarUsuario();
    // }
    scaffoldMessenger.showSnackBar(snackBar);
  }

  onPressBtnChangeInfo() {
    // Captura o ScaffoldMessenger antes de qualquer operaÃ§Ã£o assÃ­ncrona
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final null_check = (_formKey.currentState)?.validate();
    if ((_formKey.currentState)!.validate()) {
      _changePersonalInfo(scaffoldMessenger, emailId);

      if (_auth.currentUser?.uid != null) {
        Navigator.pushNamed(context, '/personalInfoView');
      }
    } else {
      scaffoldMessenger.showSnackBar(SnackBars.erroAoAtualizarUsuario());
    }
  }

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
          final user = _auth.currentUser;
          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          final data = userDoc.data() as Map<String, dynamic>;

          if ((data['birth']) != null) {
            _birthController.text = data['birth'];
          }
          if ((data['height']) != null) {
            _heightController.text = data['height'];
          }
          _nameController.text = data['name'];

          if (snapshot.hasData) {
            if (snapshot.hasData) {
              return Column(children: [
                const Icon(Icons.account_circle, size: 100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nome',
                          ),
                        ),
                        TextFormField(
                          controller: _birthController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Data de Nascimento',
                          ),
                        ),
                        TextFormField(
                          controller: _heightController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Altura',
                          ),
                        ),
                        const SizedBox(height: 30),
                        BtnFilled(
                            text: "Confirmar",
                            onPressed: () {
                              if (user != null) {
                                onPressBtnChangeInfo();
                              }
                              Navigator.pushNamed(context, '/personalInfoView');
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: Colors.white),
                        const SizedBox(height: 30),
                        BtnFilled(
                            text: "Voltar",
                            onPressed: () {
                              Navigator.pushNamed(context, '/personalInfoView');
                            },
                            backgroundColor: Colors.white,
                            textColor: Theme.of(context).primaryColor),
                      ])),
                ),
              ]);
            }
          }
          return const Text("Loading");
        });
  }
}
