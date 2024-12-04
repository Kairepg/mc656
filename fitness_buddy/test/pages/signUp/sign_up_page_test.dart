import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/signUp/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_page_test.mocks.dart';

// Gerar mocks para FirebaseAuth
@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {
  group("Classes de Equivalência", (){
    testWidgets(
      'Classe válida: Cadastro bem-sucedido',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser();

        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'testadastro@teste.com',
          password: 'senha12345',
        )).thenAnswer((_) async => mockUserCredential);

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn('testadastro@teste.com');

        await tester.pumpWidget(
            MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth)));

        final nameField = find.byKey(const Key('nameField'));
        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
        final signUpButton = find.byKey(const Key('signUpButton'));

        await tester.enterText(nameField, 'Testadastro');
        await tester.enterText(emailField, 'testadastro@teste.com');
        await tester.enterText(passwordField, 'senha12345');
        await tester.enterText(confirmPasswordField, 'senha12345');

        await tester.tap(signUpButton);

        await tester.pump();

        verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'testadastro@teste.com',
          password: 'senha12345',
        )).called(1);

        expect(mockFirebaseAuth.currentUser, isNotNull);

        expect(find.text("Usuário cadastrado com sucesso"), findsOneWidget);
      },
    );

    testWidgets(
      'Cadastro inválido: email-already-in-use',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUser = MockUser();

        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'testexistente@teste.com',
          password: 'senha12345',
        )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn('testexistente@teste.com');

        await tester.pumpWidget(
            MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth)));

        final nameField = find.byKey(const Key('nameField'));
        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
        final signUpButton = find.byKey(const Key('signUpButton'));

        await tester.enterText(nameField, 'Testexistente');
        await tester.enterText(emailField, 'testexistente@teste.com');
        await tester.enterText(passwordField, 'senha12345');
        await tester.enterText(confirmPasswordField, 'senha12345');

        await tester.tap(signUpButton);

        await tester.pump();

        verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'testexistente@teste.com',
          password: 'senha12345',
        )).called(1);

        expect(find.text('O email já está em uso'), findsOneWidget);
      },
    );

    testWidgets(
      'Cadastro inválido: weak-password',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUser = MockUser();

        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'testexistente@teste.com',
          password: '12345',
        )).thenThrow(FirebaseAuthException(code: 'weak-password'));

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn('testexistente@teste.com');

        await tester.pumpWidget(
            MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth)));

        final nameField = find.byKey(const Key('nameField'));
        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
        final signUpButton = find.byKey(const Key('signUpButton'));

        await tester.enterText(nameField, 'Testexistente');
        await tester.enterText(emailField, 'testexistente@teste.com');
        await tester.enterText(passwordField, '12345');
        await tester.enterText(confirmPasswordField, '12345');

        await tester.tap(signUpButton);

        await tester.pump();

        expect(find.text('A senha é muito fraca'), findsOneWidget);
      },
    );
  });
 testWidgets(
    'Cadastro inválido com confirmação de senha diferente',
    (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      
      // Construir a tela de cadastro
      await tester.pumpWidget(
          MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth)));

      final nameField = find.byKey(const Key('nameField'));
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
      final signUpButton = find.byKey(const Key('signUpButton'));

      await tester.enterText(nameField, 'Testadastro');
      await tester.enterText(emailField, 'testadastro@teste.com');
      await tester.enterText(passwordField, 'senha12345');
      await tester.enterText(confirmPasswordField, 'senha54321');

      // Clicar no botão de cadastro
      await tester.tap(signUpButton);

      // Atualizar a tela após o clique
      await tester.pump();

      verifyNever(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'testadastro@teste.com',
        password: 'senha12345',
      ));

      expect(find.text('As senhas não coincidem'), findsOneWidget);
    },
  );
}
