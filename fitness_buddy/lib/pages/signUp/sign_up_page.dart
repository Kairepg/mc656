import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/signUp/sign_up_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerUser(scaffoldMessenger) async {
    SnackBar? snackBar;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final user = _auth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .set({
          'name': _nameController.text,
        });
      }

      snackBar = SnackBars.usuarioCadastrado();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBar = SnackBars.senhaFraca();
      } else if (e.code == 'email-already-in-use') {
        snackBar = SnackBars.emailEmUso();
      }
    } catch (e) {
      debugPrint(e.toString());
      snackBar = SnackBars.erroAoCadastrar();
    }

    scaffoldMessenger.showSnackBar(snackBar);
  }

  onPressBtnSingUp() {
    // Captura o ScaffoldMessenger antes de qualquer operação assíncrona
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      _registerUser(scaffoldMessenger);

      if(_auth.currentUser?.uid != null) {
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } else {
      scaffoldMessenger.showSnackBar(SnackBars.erroAoCadastrar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
                title: "Cadastro",
                subtitle: "Crie uma conta para começar a usar o Fitness Buddy"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      // style: const TextStyle(fontSize: 12.0),
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu nome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      // style: const TextStyle(fontSize: 12.0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      // style: const TextStyle(fontSize: 12.0),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira sua senha';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                          labelText: 'Confirme sua senha'),
                      // style: const TextStyle(fontSize: 12.0),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme sua senha';
                        }
                        if (value != _passwordController.text) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    // Dá para juntar isso em um widget
                    BtnFilled(
                      text: "Cadastrar",
                      onPressed: onPressBtnSingUp,
                      backgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text("Já tem uma conta?",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 5),
                    BtnFilled(
                      text: "Fazer login",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
