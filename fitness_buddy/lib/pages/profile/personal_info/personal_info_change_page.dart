import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:flutter/material.dart';

class PersonalInfoChangePage extends MenuNavigatorPage {
  final FirebaseAuth? firebaseAuth;
  final FirebaseFirestore? firebaseInstance;
  const PersonalInfoChangePage(
      {super.key, this.firebaseAuth, this.firebaseInstance});

  @override
  State<PersonalInfoChangePage> createState() => _PersonalInfoChangePageState();
}

class _PersonalInfoChangePageState extends State<PersonalInfoChangePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String emailId = '';
  FirebaseAuth? _auth;
  FirebaseFirestore? users;

  void verifyDateTime(String validade) {
    List<String> validadeSplit = validade.split('/');

    if (validadeSplit.length > 1) {
      String day = validadeSplit[0].toString();
      String month = validadeSplit[1].toString();
      String year = validadeSplit[2].toString();
      if (int.parse(day) > 31 || int.parse(month) > 12) {
        throw const FormatException();
      } else if ((int.parse(day)) == 31 &&
          (((int.parse(month)) < 8 && (int.parse(month)) % 2 == 0) ||
              ((int.parse(month)) >= 8 && (int.parse(month)) % 2 != 0))) {
        throw const FormatException();
      }
      DateTime.parse('$year-$month-$day 00:00:00.000');
    } else {
      throw const FormatException();
    }
  }

  Future<void> _changePersonalInfo(scaffoldMessenger) async {
    SnackBar? snackBar;
    final user = _auth!.currentUser;

    try {
      verifyDateTime(_birthController.text);

      if (_nameController.text.isEmpty) {
        throw (FirebaseAuthException(code: 'invalid-display-name'));
      }

      if (user != null) {
        await users!.collection('users').doc(emailId).update({
          "name": _nameController.text,
          "birth": _birthController.text,
          "height": _heightController.text
        });
      }

      snackBar = SnackBars.usuarioAtualizado();
    } on FormatException {
      snackBar = SnackBars.dataInvalida();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-display-name') {
        snackBar = SnackBars.nomeVazio();
      }
    }
    scaffoldMessenger.showSnackBar(snackBar);
  }

  onPressBtnChangeInfo() {
    // Captura o ScaffoldMessenger antes de qualquer operação assíncrona
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final null_check = (_formKey.currentState)?.validate();
    if ((_formKey.currentState)!.validate()) {
      _changePersonalInfo(scaffoldMessenger);

      if (_auth!.currentUser?.uid != null &&
          _auth!.currentUser?.uid != "test") {
        Navigator.pushNamed(context, '/personalInfoView');
      }
    } else {
      scaffoldMessenger.showSnackBar(SnackBars.erroAoAtualizarUsuario());
    }
  }

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

  Future<Map<String, dynamic>> _getUserData() async {
    final userDoc = await users!.collection('users').doc(emailId).get();
    return userDoc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          final user = _auth!.currentUser;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.hasError) {
            return const Text("Error loading data");
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            if ((data['birth']) != null) {
              _birthController.text = data['birth'];
            }
            if ((data['height']) != null) {
              _heightController.text = data['height'];
            }
            _nameController.text = data['name'];

            return Column(children: [
              const Icon(Icons.account_circle, size: 100),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        key: const Key("nameField"),
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Nome',
                        ),
                      ),
                      TextFormField(
                        key: const Key("birthField"),
                        controller: _birthController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Data de Nascimento',
                        ),
                      ),
                      TextFormField(
                        key: const Key("heightField"),
                        controller: _heightController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Altura',
                        ),
                      ),
                      const SizedBox(height: 30),
                      BtnFilled(
                          key: const Key('confirmButton'),
                          text: "Confirmar",
                          onPressed: () {
                            if (user != null) {
                              onPressBtnChangeInfo();
                            }
                            if (_auth!.currentUser?.email !=
                                "teste@teste.com") {
                              Navigator.pushNamed(context, '/personalInfoView');
                            }
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

          return const Text("No data available");
        });
  }
}
