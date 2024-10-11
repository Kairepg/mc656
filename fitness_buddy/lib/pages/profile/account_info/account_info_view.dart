import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Widget getUserPassword(documentId) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  return FutureBuilder<DocumentSnapshot>(
    future: users.doc(documentId).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        return const Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Text("${data['password']}");
      }

      return const Text("loading");
    },
  );
}

// String getUserPasswordString(documentId) {
//   final ref = FirebaseFirestore.instance.collection('users').doc(documentId);
//   Map<String, dynamic> data;
//   String val = 'bruno';
//   return ref.get().then((value) => {
//     data = value.data() as Map<String, dynamic>,
//     val = data['password'],
//   });
// }
//   ref.get().then(
//     (snapshot) => {
//       data = snapshot.data() as Map<String, dynamic>,
//       val = data['password']
//     }
//   );
//   return val;
// }