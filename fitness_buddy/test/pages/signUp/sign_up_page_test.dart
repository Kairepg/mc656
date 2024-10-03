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
  testWidgets(
    'Testando tela de cadastro com Firebase',
    (WidgetTester tester) async {
      // Mock do FirebaseAuth
      final mockFirebaseAuth = MockFirebaseAuth();
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      // Configurar o comportamento simulado do cadastro
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'testadastro@teste.com',
        password: 'senha12345',
      )).thenAnswer((_) async => mockUserCredential);

      // Simular que o usuário está autenticado após o cadastro
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      // Simular o comportamento do email do usuário
      when(mockUser.email).thenReturn('testadastro@teste.com');

      // Construir a tela de cadastro
      await tester.pumpWidget(
          MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth)));

      // Encontrar os campos de texto e o botão
      final nameField = find.byKey(const Key('nameField'));
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
      final signUpButton = find.byKey(const Key('signUpButton'));

      // Inserir texto nos campos
      await tester.enterText(nameField, 'Testadastro');
      await tester.enterText(emailField, 'testadastro@teste.com');
      await tester.enterText(passwordField, 'senha12345');
      await tester.enterText(confirmPasswordField, 'senha12345');

      // Clicar no botão de cadastro
      await tester.tap(signUpButton);

      // // Atualizar a tela após o clique
      await tester.pump();

      // Verificar se o método de login foi chamado
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'testadastro@teste.com',
        password: 'senha12345',
      )).called(1);

      // Verificar se o usuário foi autenticado
      expect(mockFirebaseAuth.currentUser, isNotNull);
    },
  );
}