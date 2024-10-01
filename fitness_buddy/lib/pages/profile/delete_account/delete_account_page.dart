import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends MenuNavigatorPage {
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
