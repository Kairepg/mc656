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
  testWidgets(
    'Testando tela de login com Firebase',
    (WidgetTester tester) async {
      // Mock do FirebaseAuth
      final mockFirebaseAuth = MockFirebaseAuth();
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser(); // Simular um usuário autenticado

      // Configurar o comportamento simulado do login
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'teste@teste.com',
        password: 'senha123',
      )).thenAnswer((_) async => mockUserCredential);

      // Simular que o usuário está autenticado após o login
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      // Simular o comportamento do email do usuário
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

      // Verificar se o método de login foi chamado
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'teste@teste.com',
        password: 'senha123',
      )).called(1);

      // Verificar se o usuário foi autenticado
      expect(mockFirebaseAuth.currentUser, isNotNull);
    },
  );
}
