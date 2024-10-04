import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_view.dart';
import 'package:fitness_buddy/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';


class PersonalInfoViewPage extends MenuNavigatorPage {
  const PersonalInfoViewPage({super.key});

  @override
  State<PersonalInfoViewPage> createState() => _PersonalInfoViewPageState();
}

class _PersonalInfoViewPageState extends State<PersonalInfoViewPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String emailId = '';

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
          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          final data = userDoc.data() as Map<String, dynamic>;

          Text displayBirth = const Text("N�o informado.");
          Text displayHeight = const Text("N�o informado.");
          if ((data['birth']) != null) {
            displayBirth = Text(data['birth']);
          }
          if ((data['height']) != null) {
            displayHeight = Text(data['height']);
          }

          if (snapshot.hasData) {
            return Column(children: [
              DisplayCard(
                text: Text(data['name']),
                subtitle: "Nome:",
                showIcon: false,
              ),
              DisplayCard(
                text: displayBirth,
                subtitle: "Data de Nascimento:",
                showIcon: false,
              ),
              DisplayCard(
                text: displayHeight,
                subtitle: "Altura:",
                showIcon: false,
              ),
              const SizedBox(height: 30),
              BtnFilled(
                text: "Alterar dados",
                onPressed: () {
                  Navigator.pushNamed(context, '/personalInfoChange');
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






class PersonalInfoChange extends MenuNavigatorPage {
  const PersonalInfoChange({super.key});

  @override
  State<PersonalInfoChange> createState() => _PersonalInfoChangeState();
}

class _PersonalInfoChangeState extends State<PersonalInfoChange> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String emailId = '';



  void verifyDateTime(String validade)
{
  List<String> validadeSplit = validade.split('/');
  
  if(validadeSplit.length > 1)
  {
      String day = validadeSplit[0].toString();
      String month = validadeSplit[1].toString(); 
      String year = validadeSplit[2].toString();
      if (int.parse(day) > 31 || int.parse(month) > 12){
        throw const FormatException();
      } else if ((int.parse(day)) == 31 && 
                (((int.parse(month)) < 8 && (int.parse(month)) % 2 == 0) ||
                ((int.parse(month)) >= 8 && (int.parse(month)) % 2 != 0))){
        throw const FormatException();    
          
      }
     DateTime.parse('$year-$month-$day 00:00:00.000');
  }
  else{
    throw const FormatException();
  }
 
}


  Future<void> _changePersonalInfo(scaffoldMessenger, documentId) async {
    SnackBar? snackBar;
    final user = _auth.currentUser;

    try {

    verifyDateTime(_birthController.text);

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .update({
        "name": _nameController.text,
        "birth": _birthController.text,
        "height": _heightController.text
      });
    }

    snackBar = SnackBars.usuarioAtualizado();
    } on FormatException catch (e) {
      snackBar = SnackBars.dataInvalida();
    }
    scaffoldMessenger.showSnackBar(snackBar);
  }

  onPressBtnChangeInfo() {
    // Captura o ScaffoldMessenger antes de qualquer operação assíncrona
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final null_check = (_formKey.currentState)?.validate();
    if ((_formKey.currentState)!.validate()) {
      _changePersonalInfo(scaffoldMessenger, emailId);

      if (_auth.currentUser?.uid != null) {
        Navigator.pushNamed(context, '/personalInfoView');
      }
    } else {
      scaffoldMessenger.showSnackBar(SnackBars.erroAoAtualizarUsuario());
    }
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
          final user = _auth.currentUser;
          final userDoc =
              snapshot.data!.docs.firstWhere((doc) => doc.id == emailId);
          final data = userDoc.data() as Map<String, dynamic>;

          if ((data['birth']) != null) {
            _birthController.text = data['birth'];
          }
          if ((data['height']) != null) {
            _heightController.text = data['height'];
          }
          _nameController.text = data['name'];

          if (snapshot.hasData) {
            if (snapshot.hasData) {
              return Column(children: [
                const Icon(Icons.account_circle, size: 100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          key: const Key("nameField"),
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nome',
                          ),
                        ),
                        TextFormField(
                          key: const Key("birthField"),
                          controller: _birthController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Data de Nascimento',
                          ),
                        ),
                        TextFormField(
                          key: const Key("heightField"),
                          controller: _heightController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Altura',
                          ),
                        ),
                        const SizedBox(height: 30),
                        BtnFilled(
                            key: const Key('confirmButton'),
                            text: "Confirmar",
                            onPressed: () {
                              if (user != null) {
                                onPressBtnChangeInfo();
                              }
                              Navigator.pushNamed(context, '/personalInfoView');
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: Colors.white),
                        const SizedBox(height: 30),
                        BtnFilled(
                            text: "Voltar",
                            onPressed: () {
                              Navigator.pushNamed(context, '/personalInfoView');
                            },
                            backgroundColor: Colors.white,
                            textColor: Theme.of(context).primaryColor),
                      ])),
                ),
              ]);
            }
          }
          return const Text("Loading");
        });
  }
}
