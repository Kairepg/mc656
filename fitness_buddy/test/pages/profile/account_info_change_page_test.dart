import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/profile/account_info/account_info_change_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'account_info_change_page_test.mocks.dart';

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

  String oldPassword = "senhaantiga";

  Map<String, dynamic> data = {'password': oldPassword};

  when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
  when(mockUser.email).thenReturn(documentPath);
  when(mockUser.uid).thenReturn("test");

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockDocumentReference = MockDocumentReference();
    mockCollectionReference = MockCollectionReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
  });

  testWidgets('Testando alteração de dados pessoais com Firebase',
      (WidgetTester tester) async {
    String newPassword = "senhanova";

    Map<String, dynamic> newData = {'password': newPassword};

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
        body: AccountInfoChangePage(
          firebaseAuth: mockFirebaseAuth,
          firebaseInstance: mockFirestore, // Pass the mock Firestore
        ),
      ),
    ));

    expect(find.text('Loading'), findsOneWidget);

    await tester.pumpAndSettle();

    // Localizando o campo de senha e o botão de confirmar
    final passwordField = find.byKey(const Key('passwordField'));
    final confirmButton = find.byKey(const Key('confirmButton'));

    // Verificar se o campo existem
    expect(passwordField, findsOneWidget);

    // Inserir texto nos campos
    await tester.enterText(passwordField, newPassword);

    // Clicar no botão de confirmação
    await tester.tap(confirmButton);

    // Atualizar a tela após o clique
    await tester
        .pumpAndSettle(); // Garantir que todas as animações e mudanças de estado terminem

    // Verificar se o SnackBar foi exibido
    expect(
        find.text('Dados do usuário atualizados com sucesso'), findsOneWidget);

    //Verificar se o método de atualização de senha do firebase auth foi chamado
    verify(mockUser.updatePassword(newPassword)).called(1);

    //Verificar se os método de atualização de dados do firestore foi chamado com oa nova senha
    verify(mockDocumentReference.update(newData)).called(1);

    // Mensagens de log para diagnóstico
    debugPrint("Senha atualizada: $newPassword");

    // Verificar se o SnackBar realmente foi exibido (diagnóstico extra)
    expect(find.byType(SnackBar), findsOneWidget);
  });
  testWidgets(
    'Testando alteração de senha com senha fraca ou vazia',
    (WidgetTester tester) async {
      //aqui, pode ser escolhida uma senha fraca (< 6 digitos) ou string vazia
      String newPassword = "fraca";

      Map<String, dynamic> newData = {'password': newPassword};

      // Configuração dos mocks
      when(mockFirestore.collection(collectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(documentPath))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(data);

      // mock da exceção de senha fraca ou vazia
      if (newPassword.isNotEmpty) {
        when(mockUser.updatePassword(newPassword))
            .thenThrow(FirebaseAuthException(code: 'weak-password'));
      } else {
        when(mockUser.updatePassword(null))
            .thenThrow(FirebaseAuthException(code: 'invalid-password'));
      }

      // Aqui você está incluindo um Scaffold para garantir que a tela renderize corretamente
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AccountInfoChangePage(
            firebaseAuth: mockFirebaseAuth,
            firebaseInstance: mockFirestore, // Pass the mock Firestore
          ),
        ),
      ));

      expect(find.text('Loading'), findsOneWidget);

      await tester.pumpAndSettle();

      // Localizando o campo de senha e o botão de confirmar
      final passwordField = find.byKey(const Key('passwordField'));
      final confirmButton = find.byKey(const Key('confirmButton'));

      // Verificar se o campo existe
      expect(passwordField, findsOneWidget);

      // Inserir texto nos campos
      await tester.enterText(passwordField, newPassword);

      // Clicar no botão de confirmação
      await tester.tap(confirmButton);

      // Atualizar a tela após o clique
      await tester
          .pumpAndSettle(); // Garantir que todas as animações e mudanças de estado terminem

      if (newPassword.isNotEmpty) {
        expect(find.text('A senha é muito fraca'), findsOneWidget);
      } else {
        expect(find.text("O campo 'senha' não pode ser vazio"), findsOneWidget);
      }
      verify(mockUser.updatePassword(newPassword)).called(1);

      //Verificar se os método de atualização de dados do firestore foi chamado com oa nova senha
      verifyNever(mockDocumentReference.update(newData));

      // Mensagens de log para diagnóstico
      debugPrint("Senha mantida: $oldPassword");

      // Verificar se o SnackBar realmente foi exibido (diagnóstico extra)
      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
}
