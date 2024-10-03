import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/account_info/account_info_view.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:flutter/material.dart';

class AccountInfoView extends MenuNavigatorPage {
  const AccountInfoView({super.key});

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
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

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();


    return StreamBuilder(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          
          Widget emailDisplay = Text(emailId);
          Widget visibility = IconButton(
            onPressed: _togglePasswordView,
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
            ),
          );

          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          
          final data = userDoc.data() as Map<String, dynamic>;


          if (snapshot.hasData) {
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
          return const Text("Loading");
        });
  }
}

class AccountInfoChange extends MenuNavigatorPage {
  const AccountInfoChange({super.key});

  @override
  State<AccountInfoChange> createState() => _AccountInfoChangeState();
}

class _AccountInfoChangeState extends State<AccountInfoChange> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String emailId = '';
  String passwordDisplay = '';



  @override
  void initState() {
    final user = _auth.currentUser;
    if (user != null) {
      emailId = user.email ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    Widget emailDisplay = Text(emailId);

    return StreamBuilder(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final user = _auth.currentUser;

          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          final data = userDoc.data() as Map<String, dynamic>;

          if (snapshot.hasData) {
            return Column(children: [
              const Icon(Icons.account_circle, size: 100),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: TextFormField(
                    initialValue: '${(emailDisplay as Text).data}',
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                    onChanged: (name) {
                      setState(() {
                        _emailController.text = name;
                      });
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: TextFormField(
                    initialValue: data['password'],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    onChanged: (senha) {
                      setState(() {
                        _passwordController.text = senha;
                      });
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Conta Privada',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              BtnFilled(
                  text: "Voltar",
                  onPressed: () {
                    Navigator.pushNamed(context, '/accountInfoView');
                  },
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).primaryColor),
              const SizedBox(height: 30),
              BtnFilled(
                  text: "Confirmar",
                  onPressed: () {
                    if (user != null) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(emailId)
                          .update({'password': _passwordController.text});
                      user.updatePassword(_passwordController.text);
                    }
                    Navigator.pushNamed(context, '/accountInfoView');
                  },
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).primaryColor)
            ]);
          }

          return const Text("Loading");
        });
  }
}
