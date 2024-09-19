import 'package:fitness_buddy/pages/login/login_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginUser(scaffoldMessenger) async {
    SnackBar? snackBar;
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );


      snackBar = SnackBars.usuarioLogado();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        snackBar = SnackBars.emailNaoEncontrado();
      } else if (e.code == 'invalid-credential') {
        snackBar = SnackBars.senhaErrada();
      }
    } catch (e) {
      debugPrint(e.toString());
      snackBar = SnackBars.erroAoLogar();
    }

    scaffoldMessenger.showSnackBar(snackBar);
  }

  onPressBtnLogin() {
    // Captura o ScaffoldMessenger antes de qualquer operação assíncrona
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      _loginUser(scaffoldMessenger);
    } else {
      scaffoldMessenger.showSnackBar(SnackBars.erroAoLogar());
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
                title: "Login",
                subtitle: "Entre na sua conta da Fitness Buddy"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                    const SizedBox(height: 30),
                    // Dá para juntar isso em um widget
                    BtnFilled(
                      text: "Entrar",
                      onPressed: onPressBtnLogin,
                      backgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text("Não tem uma conta?",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 5),
                    BtnFilled(
                      text: "Fazer cadastro",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
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
