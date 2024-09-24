import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class AccountInfo extends ProfilePage {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'E-mail',
            ),
          ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Senha',
            ),
          ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Conta Privada',
            ),
          ),
      ),  
    ]);
  }
}
