import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget getUserName(documentId) {
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

        return Text("${data['name']}");
      }

      return const Text("loading");
    },
  );
}

Widget getUserBirth(documentId) {
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

        return Text("${data['birth']}");
      }

      return const Text("loading");
    },
  );
}

Widget getUserHeight(documentId) {
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

        return Text("${data['height']}");
      }

      return const Text("loading");
    },
  );
}