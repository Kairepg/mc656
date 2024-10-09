import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:flutter/material.dart';

class AccountInfoChangePage extends MenuNavigatorPage {
  const AccountInfoChangePage({super.key});

  @override
  State<AccountInfoChangePage> createState() => _AccountInfoChangeState();
}

class _AccountInfoChangeState extends State<AccountInfoChangePage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  String emailId = '';
  String passwordDisplay = '';

  Future<void> _changeAccountInfo(scaffoldMessenger, documentId) async {
    SnackBar? snackBar;
    final user = _auth.currentUser;
    
    try {
      if (user != null) {
        await user.updatePassword(_passwordController.text);
        FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update({"password": _passwordController.text});
      }

      snackBar = SnackBars.usuarioAtualizado();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBar = SnackBars.senhaFraca();
      } else if (e.code == 'email-already-in-use') {
        snackBar = SnackBars.emailEmUso();
      }
    } catch (e) {
      debugPrint(e.toString());
      snackBar = SnackBars.erroAoAtualizarUsuario();
    }
    scaffoldMessenger.showSnackBar(snackBar);
  }

  onPressBtnChangeInfo() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if ((_formKey.currentState)!.validate()) {
      _changeAccountInfo(scaffoldMessenger, emailId);

      if (_auth.currentUser?.uid != null) {
        Navigator.pushNamed(context, '/accountInfoView');
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

  Future<Map<String, dynamic>> _getUserData() async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(emailId).get();
    return userDoc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          final user = _auth.currentUser;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.hasError) {
            return const Text("Error loading data");
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            _passwordController.text = data['password'];

            return Column(children: [
              const Icon(Icons.account_circle, size: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Senha',
                      ),
                    ),
                    const SizedBox(height: 30),
                    BtnFilled(
                        text: "Confirmar",
                        onPressed: () {
                          if (user != null) {
                            onPressBtnChangeInfo();
                          }
                          Navigator.pushNamed(context, '/accountInfoView');
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white),
                    const SizedBox(height: 30),
                    BtnFilled(
                        text: "Voltar",
                        onPressed: () {
                          Navigator.pushNamed(context, '/accountInfoView');
                        },
                        backgroundColor: Colors.white,
                        textColor: Theme.of(context).primaryColor),
                    const SizedBox(height: 30)
                  ]),
                ),
              ),
            ]);
          }

          return const Text("No data available");
        });
  }
}
