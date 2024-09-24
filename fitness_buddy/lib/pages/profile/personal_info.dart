import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends ProfilePage {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.account_circle, size: 100),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nome',
            ),
          ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Data de Nascimento',
            ),
          ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Altura',
            ),
          ),
      ),  
    ]);
  }
}
