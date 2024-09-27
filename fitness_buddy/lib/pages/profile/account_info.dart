import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/personal_info.dart';
import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:fitness_buddy/pages/profile/profile_view.dart';
import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/material.dart';




class AccountInfoView extends ProfilePage {
  const AccountInfoView({super.key});

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  bool _isHidden = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;


   void _togglePasswordView() {
    setState(() {
        _isHidden = !_isHidden;
    });
}

 
  Widget GetUserName(documentId) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        
          return Text("${data['name']}");
        }

        return const Text("loading");
      },
    );
  }



 Widget GetUserPassword(documentId) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        
          return Text("${data['password']}");
        }

        return const Text("loading");
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    String email_id = '';

    if (user != null){
      email_id = user.email ?? '';
    }
   
    Widget name_display = GetUserName(email_id);
    Widget email_display = Text(email_id);
    Widget password_display = GetUserPassword(email_id);

    Widget visibility = IconButton(
      onPressed: _togglePasswordView,
      icon: Icon(
            _isHidden ?         /// CHeck Show & Hide.
             Icons.visibility :
            Icons.visibility_off,
            ), 
    );
   
    return Column(children: [
      DisplayCard(
        text: name_display,
        subtitle: "Nome:",
        showIcon: false,
      ),
      DisplayCard(
        text: email_display,
        subtitle: "Email:",
        showIcon: false,
      ),
       
      DisplayCard(
          text: _isHidden ? password_display : const Text("********"),
          subtitle: "Senha:",
          showIcon: true,
          icon: visibility
      ), 
       
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
          textColor: Theme.of(context).primaryColor
        )
    ]);
  }
}






class AccountInfoChange extends ProfilePage {
  const AccountInfoChange({super.key});

  @override
  State<AccountInfoChange> createState() => _AccountInfoChangeState();
}

class _AccountInfoChangeState extends State<AccountInfoChange> {
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
      const SizedBox(height: 30),
        BtnFilled(
          text: "Voltar",
          onPressed: () {
            Navigator.pushNamed(context, '/accountInfoView');
          },
          backgroundColor: Colors.white,
          textColor: Theme.of(context).primaryColor
        ) 
    ]);
  }
}
