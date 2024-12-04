import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

// Gerar mocks para FirebaseAuth
@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {
  group("Classes de equivalência", ()
  {
    testWidgets(
      'Classe válida: login bem-sucedido',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser(); // Simular um usuário autenticado

        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'teste@teste.com',
          password: 'senha123',
        )).thenAnswer((_) async => mockUserCredential);

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn('teste@teste.com');

        // Construir a tela de login
        await tester.pumpWidget(
            MaterialApp(home: LoginPage(firebaseAuth: mockFirebaseAuth)));

        // Encontrar os campos de texto e o botão
        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final loginButton = find.byKey(const Key('loginButton'));

        // Inserir texto nos campos
        await tester.enterText(emailField, 'teste@teste.com');
        await tester.enterText(passwordField, 'senha123');

        // Clicar no botão de login
        await tester.tap(loginButton);

        // // Atualizar a tela após o clique
        await tester.pump();

        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'teste@teste.com',
          password: 'senha123',
        )).called(1);

        expect(mockFirebaseAuth.currentUser, isNotNull);

        expect(find.text("Login realizado com sucesso"), findsOneWidget);
      },
    );

    testWidgets(
      'Classe inválida: invalid-credential',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUser = MockUser();
      

        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'teste@teste.com',
          password: 'senha_invalida',
        )).thenThrow(FirebaseAuthException(
          code: 'invalid-credential'
        ));

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn('teste@teste.com');

        await tester.pumpWidget(
            MaterialApp(home: LoginPage(firebaseAuth: mockFirebaseAuth)));

        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final loginButton = find.byKey(const Key('loginButton'));

        await tester.enterText(emailField, 'teste@teste.com');
        await tester.enterText(passwordField, 'senha_invalida');

        await tester.tap(loginButton);

        await tester.pump();

        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'teste@teste.com',
          password: 'senha_invalida',
        )).called(1);

        expect(find.text("Login inválido"),findsOneWidget );
      },
    );

    testWidgets(
      'Classe inválida: invalid-email',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUser = MockUser();
      

        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'email_invalido.com',
          password: 'senha_invalida',
        )).thenThrow(FirebaseAuthException(
          code: 'invalid-email'
        ));

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn('email_invalido.com');

        await tester.pumpWidget(
            MaterialApp(home: LoginPage(firebaseAuth: mockFirebaseAuth)));

        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final loginButton = find.byKey(const Key('loginButton'));

        await tester.enterText(emailField, 'email_invalido.com');
        await tester.enterText(passwordField, 'senha_invalida');

        await tester.tap(loginButton);

        await tester.pump();

        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'email_invalido.com',
          password: 'senha_invalida',
        )).called(1);

        expect(find.text("Login inválido"),findsOneWidget );
      },
    );

    testWidgets(
      'Classe Inválida: Erro desconhecido',
      (WidgetTester tester) async {
        final mockFirebaseAuth = MockFirebaseAuth();
        final mockUser = MockUser();
      

        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'email_invalido.com',
          password: 'senha_invalida',
        )).thenThrow(FirebaseAuthException(
          code: 'wrong-password'
        ));

        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        when(mockUser.email).thenReturn('email_invalido.com');

        await tester.pumpWidget(
            MaterialApp(home: LoginPage(firebaseAuth: mockFirebaseAuth)));

        final emailField = find.byKey(const Key('emailField'));
        final passwordField = find.byKey(const Key('passwordField'));
        final loginButton = find.byKey(const Key('loginButton'));

        await tester.enterText(emailField, 'email_invalido.com');
        await tester.enterText(passwordField, 'senha_invalida');

        await tester.tap(loginButton);

        await tester.pump();

        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'email_invalido.com',
          password: 'senha_invalida',
        )).called(1);

        expect(find.text("Erro ao logar usuário"),findsOneWidget );
      },
    );
  });

}
