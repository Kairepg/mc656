import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:fitness_buddy/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends ProfilePage {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      CardButton(
        onPressed: () {
          Navigator.pushNamed(context, '/deleteAccount');
        },
        text: 'Apagar Conta',
      ),
    ]);
  }
}
