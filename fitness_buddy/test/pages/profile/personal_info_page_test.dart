import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/personal_info/personal_info_change_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'personal_info_page_test.mocks.dart';

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
  final mockUser = MockUser(); // Simular um usuário autenticado

  const String collectionPath = 'users';
  String? documentPath = 'teste@teste.com';

  const Map<String, dynamic> data = {
    'name': "nomeAntigo",
    'height': '1.80',
    'birth': '01/01/2001'
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
    'Testando visualização de dados pessoais com Firebase',
    (WidgetTester tester) async {
      String newName = "novoNome";
      String newBirth = "01/01/2005";
      String newHeight = "1.70";

      // Configuração dos mocks
      when(mockFirestore.collection(collectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(documentPath))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(data);

      // Aqui você está incluindo um Scaffold para garantir que a tela renderize corretamente
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PersonalInfoChangePage(
            firebaseAuth: mockFirebaseAuth,
            firebaseInstance: mockFirestore, // Pass the mock Firestore
          ),
        ),
      ));

      expect(find.text('Loading'), findsOneWidget);

      await tester.pumpAndSettle();

      // Localizando os campos e o botão
      final nameField = find.byKey(const Key('nameField'));
      final birthField = find.byKey(const Key('birthField'));
      final heightField = find.byKey(const Key('heightField'));
      final confirmButton = find.byKey(const Key('confirmButton'));

      // Verificar se os campos existem
      expect(nameField, findsOneWidget);
      expect(birthField, findsOneWidget);
      expect(heightField, findsOneWidget);

      // Inserir texto nos campos
      await tester.enterText(nameField, newName);
      await tester.enterText(birthField, newBirth);
      await tester.enterText(heightField, newHeight);

      // Clicar no botão de confirmação
      await tester.tap(confirmButton);

      // Atualizar a tela após o clique
      await tester
          .pumpAndSettle(); // Garantir que todas as animações e mudanças de estado terminem

      // Verificar se o SnackBar foi exibido
      expect(find.text('Dados do usuário atualizados com sucesso'),
          findsOneWidget);

      // Mensagens de log para diagnóstico
      debugPrint("Nome atualizado: $newName");
      debugPrint("Nascimento atualizado: $newBirth");
      debugPrint("Altura atualizada: $newHeight");

      // Verificar se o SnackBar realmente foi exibido (diagnóstico extra)
      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
}
