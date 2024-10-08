import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/main.dart';
// import 'package:fitness_buddy/pages/login/login_page.dart';
import 'package:fitness_buddy/pages/profile/personal_info/personal_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'personal_info_page_test.mocks.dart';

// class MockDocumentReference extends Mock
//     implements DocumentReference<Map<String, dynamic>> {}

// class MockCollectionReference extends Mock
//     implements CollectionReference<Map<String, dynamic>> {}

// class MockDocumentSnapshot extends Mock
//     implements DocumentSnapshot<Map<String, dynamic>> {
//   // @override
//   // Map<String, dynamic>? data() {
//   //     String newName = "nomeAntigo";
//   //     String newBirth = "01/01/2001";
//   //     String newHeight = "1.80";

//   //   Map<String, dynamic> newData = {
//   //       'name': newName,
//   //       'height': newHeight,
//   //       'birth': newBirth
//   //     };

//   //   return newData;
//   // }

//   // @override
//   // String get id => 'teste@teste.com';
// }

// Gerar mocks para FirebaseAuth
@GenerateMocks([FirebaseAuth, User, UserCredential, FirebaseFirestore, CollectionReference, DocumentReference, DocumentSnapshot ])
void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockDocumentSnapshot mockDocumentSnapshot;

  // final mockUserCredential = MockUserCredential();
  final mockUser = MockUser(); // Simular um usuário autenticado
  // // final mockFirebaseFirestore = MockFirebaseFirestore();
  // final mockCollectionReference = MockCollectionReference();
  // final mockDocumentReference = MockDocumentReference();

// Simular que o usuário está autenticado após o cadastro
  when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
  // Simular o comportamento do email do usuário
  when(mockUser.email).thenReturn('testadastro@teste.com');


  const String collectionPath = 'users';
  String? documentPath = 'teste@teste.com';

  const Map<String, dynamic> data = {
    'name': "nomeAntigo",
    'height': '1.80',
    'birth': '01/01/2001'
  };

  setUp(() {
  mockFirestore = MockFirebaseFirestore();

  mockCollectionReference = MockCollectionReference();

  mockDocumentReference = MockDocumentReference();

  });

  testWidgets(
    'Testando alterações pessoais com Firebase',
    (WidgetTester tester) async {
      String newName = "nomeAntigo";
      String newBirth = "01/01/2001";
      String newHeight = "1.80";

      Map<String, dynamic> newData = {
        'name': newName,
        'height': newHeight,
        'birth': newBirth
      };

      when(mockFirestore.collection(collectionPath).snapshots())
          .thenReturn(mockCollectionReference);

      when(mockCollectionReference.doc(documentPath)).thenReturn(mockDocumentReference);

      // when(mockDocumentReference.set(data)).thenReturn());
      await mockDocumentReference.set(data);
      // when(mockDocumentSnapshot.data()).thenReturn(newData);

      // when(mockDocumentSnapshot.id).thenReturn(documentPath);

      // when(mockFirestore.doc(documentPath)).thenReturn(mockDocumentReference);

      // when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);

      // when(mockDocumentReference.update(newData)).thenAnswer((_) async {});

      //     when(mockFirestore.collection(collectionPath).doc(documentPath).set(
      //   data
      // )).thenAnswer((_) async {});

      await tester.pumpWidget(MaterialApp(
        home: PersonalInfoChange(
            firebaseAuth: mockFirebaseAuth,
            firebaseInstance: mockFirestore), // Pass the mock Firestore
      ));

      final nameField = find.byKey(const Key('nameField'));
      final birthField = find.byKey(const Key('birthField'));
      final heightField = find.byKey(const Key('heightField'));
      final confirmButton = find.byKey(const Key('confirmButton'));

      // // Inserir texto nos campos
      await tester.enterText(nameField, newName);
      await tester.enterText(birthField, newBirth);
      await tester.enterText(heightField, newHeight);

      // // Clicar no botão de login
      await tester.tap(confirmButton);

      // // // Atualizar a tela após o clique
      await tester.pump();

      // verify(mockDocumentReference.update(newData));

      expect(find.text('Dados do usuário atualizados com sucesso'),
          findsOneWidget);

      // //
      // final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      //     await firestore.collection(collectionPath).doc(documentPath).get();
      // final Map<String, dynamic> newData = documentSnapshot.data()!;

      // expect(newData as Future<void>, data);
      // expect(newData['name'], data['name']);
      // expect(newData['name'], data['name']);
    },
  );
}
