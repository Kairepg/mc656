import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/auth/login/login_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final FirebaseAuth? firebaseAuth;

  const LoginPage({super.key, this.firebaseAuth});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth? _auth;

  @override
  void initState() {
    if (widget.firebaseAuth != null) {
      _auth = widget.firebaseAuth!;
    } else {
      _auth = FirebaseAuth.instance;
    }

    // _emailController.text = "Ludivikeduardo@gmail.com";
    // _passwordController.text = "12345678";

    super.initState();
  }

  Future<void> _loginUser(context) async {
    SnackBar? snackBar;
    try {
      await _auth!.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      snackBar = SnackBars.usuarioLogado();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
        snackBar = SnackBars.loginNaoEncontrado();
      }
      else{
        snackBar = SnackBars.erroAoLogar();
      }
    } catch (e) {
      debugPrint(e.toString());
      snackBar = SnackBars.erroAoLogar();
    }

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (_auth!.currentUser != null &&
        _auth!.currentUser!.email != "teste@teste.com" &&
        _auth!.currentUser!.email != "email_invalido.com") {
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  onPressBtnLogin() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    setState(() {
      loading = true;
    });

    if (_formKey.currentState!.validate()) {
      _loginUser(context);
    } else {
      scaffoldMessenger.showSnackBar(SnackBars.erroAoLogar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: Container(),
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
                      key: const Key("emailField"),
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      key: const Key("passwordField"),
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 132),
                    // Dá para juntar isso em um widget
                    !loading
                    ? BtnFilled(
                        key: const Key("loginButton"),
                        text: "Entrar",
                        onPressed: onPressBtnLogin,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      )
                    : const CircularProgressIndicator(),
                    
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
