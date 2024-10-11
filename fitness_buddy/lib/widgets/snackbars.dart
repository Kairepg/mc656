import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar usuarioCadastrado() {
    return const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Usuário cadastrado com sucesso"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar usuarioAtualizado() {
    return const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Dados do usuário atualizados com sucesso"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar erroAoAtualizarUsuario() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Erro ao atualizar os dados do usuário"),
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

  static SnackBar senhaVazia() {
    return const SnackBar(
      backgroundColor: Colors.yellow,
      content: Text("O campo 'Senha' não pode ser vazio", style: TextStyle(color: Colors.black)),
      duration: Duration(seconds: 2),
    );
  }

   static SnackBar nomeVazio() {
    return const SnackBar(
      backgroundColor: Colors.yellow,
      content: Text("O campo 'Nome' não pode ser vazio", style: TextStyle(color: Colors.black)),
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

  static SnackBar erroDesconhecido() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Erro desconhecido"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar usuarioLogado() {
    return const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Login realizado com sucesso"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar loginNaoEncontrado() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Login inválido"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar erroAoLogar() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Erro ao logar usuário"),
      duration: Duration(seconds: 2),
    );
  }

  static SnackBar dataInvalida() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text("Data de nascimento inválida"),
      duration: Duration(seconds: 2),
    );
  }
}
