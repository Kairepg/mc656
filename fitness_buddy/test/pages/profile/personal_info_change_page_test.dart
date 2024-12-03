import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/personal_info/personal_info_change_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'personal_info_change_page_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  User,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot
])
void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  final mockUser = MockUser();

  const String collectionPath = 'users';
  String? documentPath = 'teste@teste.com';

  String oldName = "antigoNome";
  String oldBirth = "01/01/2005";
  String oldHeight = "1.70";

  Map<String, dynamic> data = {
    'name': oldName,
    'height': oldHeight,
    'birth': oldBirth
  };

  when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
  when(mockUser.email).thenReturn(documentPath);
  when(mockUser.uid).thenReturn("test");

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockDocumentReference = MockDocumentReference();
    mockCollectionReference = MockCollectionReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
  });

  testWidgets(
    'Testando alteração de dados pessoais com Firebase',
    (WidgetTester tester) async {
      String newName = "novoNome";
      String newBirth = "01/01/2005";
      String newHeight = "1.70";

      Map<String, dynamic> newData = {
        'name': newName,
        'height': newHeight,
        'birth': newBirth
      };

      when(mockFirestore.collection(collectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(documentPath))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(data);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PersonalInfoChangePage(
            firebaseAuth: mockFirebaseAuth,
            firebaseInstance: mockFirestore,
          ),
        ),
      ));

      expect(find.text('Loading'), findsOneWidget);

      await tester.pumpAndSettle();

      final nameField = find.byKey(const Key('nameField'));
      final birthField = find.byKey(const Key('birthField'));
      final heightField = find.byKey(const Key('heightField'));
      final confirmButton = find.byKey(const Key('confirmButton'));

      expect(nameField, findsOneWidget);
      expect(birthField, findsOneWidget);
      expect(heightField, findsOneWidget);

      await tester.enterText(nameField, newName);
      await tester.enterText(birthField, newBirth);
      await tester.enterText(heightField, newHeight);

      await tester.tap(confirmButton);

      await tester
          .pumpAndSettle(); // Garantir que todas as animações e mudanças de estado terminem

      expect(find.text('Dados do usuário atualizados com sucesso'),
          findsOneWidget);

      verify(mockDocumentReference.update(newData));

      debugPrint("Nome atualizado: $newName");
      debugPrint("Nascimento atualizado: $newBirth");
      debugPrint("Altura atualizada: $newHeight");

      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
  testWidgets(
    'Testando alteração de dados pessoais com data de nascimento inválida',
    (WidgetTester tester) async {
      String newName = "novoNome";
      String newBirth = "40/32/2005";
      String newHeight = "1.70";

      Map<String, dynamic> newData = {
        'name': newName,
        'height': newHeight,
        'birth': newBirth
      };

      when(mockFirestore.collection(collectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(documentPath))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(data);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PersonalInfoChangePage(
            firebaseAuth: mockFirebaseAuth,
            firebaseInstance: mockFirestore,
          ),
        ),
      ));

      expect(find.text('Loading'), findsOneWidget);

      await tester.pumpAndSettle();

      final nameField = find.byKey(const Key('nameField'));
      final birthField = find.byKey(const Key('birthField'));
      final heightField = find.byKey(const Key('heightField'));
      final confirmButton = find.byKey(const Key('confirmButton'));

      expect(nameField, findsOneWidget);
      expect(birthField, findsOneWidget);
      expect(heightField, findsOneWidget);

      await tester.enterText(nameField, newName);
      await tester.enterText(birthField, newBirth);
      await tester.enterText(heightField, newHeight);

      await tester.tap(confirmButton);

      await tester.pumpAndSettle();

      expect(find.text('Data de nascimento inválida'), findsOneWidget);

      verifyNever(mockDocumentReference.update(newData));

      debugPrint("Nome mantido: $oldName");
      debugPrint("Nascimento mantido: $oldBirth");
      debugPrint("Altura mantida: $oldHeight");

      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
}
