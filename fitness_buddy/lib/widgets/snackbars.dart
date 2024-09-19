import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar usuarioCadastrado() {
    return const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Usuário cadastrado com sucesso"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar senhaFraca() {
    return const SnackBar(
      backgroundColor: Colors.yellow,
      content: Text("A senha é muito fraca", style: TextStyle(color: Colors.black)),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar erroAoCadastrar() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Erro ao cadastrar usuário"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar emailEmUso() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("O email já está em uso"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar desconhecido() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Erro desconhecido"),
      duration: Duration(seconds: 2),
    );
  }
}