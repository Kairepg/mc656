import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/widgets/buttons.dart';
import 'package:flutter/material.dart';

class AccountInfoViewPage extends MenuNavigatorPage {
  const AccountInfoViewPage({super.key});

  @override
  State<AccountInfoViewPage> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoViewPage> {
  bool _isHidden = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String emailId = '';
  String passwordDisplay = "";

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    final user = _auth.currentUser;
    if (user != null) {
      emailId = user.email ?? '';
    }
    super.initState();
  }

  Future<DocumentSnapshot> _getUserData() async {
    return FirebaseFirestore.instance.collection('users').doc(emailId).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: _getUserData(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Widget emailDisplay = Text(emailId);
          Widget visibility = IconButton(
            onPressed: _togglePasswordView,
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
            ),
          );

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.hasError) {
            return const Text("Error loading data");
          }

          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!.data() as Map<String, dynamic>;

            return Column(children: [
              DisplayCard(
                text: emailDisplay,
                subtitle: "Email:",
                showIcon: false,
              ),
              DisplayCard(
                  text: _isHidden
                      ? Text(data['password'])
                      : const Text("********"),
                  subtitle: "Senha:",
                  showIcon: true,
                  icon: visibility),
              const SizedBox(height: 30),
              BtnFilled(
                text: "Alterar dados",
                onPressed: () {
                  Navigator.pushNamed(context, '/accountInfoChange');
                },
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              const SizedBox(height: 30),
              BtnFilled(
                  text: "Voltar",
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).primaryColor)
            ]);
          }

          return const Text("No data available");
        });
  }
}
