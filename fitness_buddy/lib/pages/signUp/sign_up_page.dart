import 'package:fitness_buddy/pages/signUp/sign_up_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> _registerUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Lide com o erro
      } else if (e.code == 'email-already-in-use') {
        // Lide com o erro
      }
    } catch (e) {
        // Lide com o erro
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
                      decoration:
                          const InputDecoration(labelText: 'Confirme sua senha'),
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
                      onPressed: () {
                        SnackBar snackBar;

                        if (_formKey.currentState!.validate()) {
                          _registerUser();  // Função para registrar usuário
                          snackBar = const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Usuário cadastrado com sucesso"),
                            duration: Duration(seconds: 2),
                          );
                        } else {
                          snackBar = const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Erro ao cadastrar usuário"),
                            duration: Duration(seconds: 2),
                          );
                        }

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
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
