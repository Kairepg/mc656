import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_buddy/pages/signUp/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_page_test.mocks.dart';

// ignore: must_be_immutable
class MockCheckbox extends Mock implements Checkbox, Diagnosticable {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockCheckbox'; // Or provide a more descriptive string
  }
}


// Gerar mocks para FirebaseAuth
@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {


  testWidgets(
    'Testando tela de cadastro com Firebase',
    (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();


      final mockCheckbox = MockCheckbox();
        // Mock the checkbox's value
      when(mockCheckbox.value).thenReturn(true); // Set the checkbox to checked
      
      

      // Configurar o comportamento simulado do cadastro
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'testadastro@teste.com',
        password: 'senha12345',
      )).thenAnswer((_) async => mockUserCredential);

      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.email).thenReturn('testadastro@teste.com');

      await tester.pumpWidget(
          MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth, checkbox: mockCheckbox)));

      final nameField = find.byKey(const Key('nameField'));
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
      final signUpButton = find.byKey(const Key('signUpButton'));

      await tester.enterText(nameField, 'Testadastro');
      await tester.enterText(emailField, 'testadastro@teste.com');
      await tester.enterText(passwordField, 'senha12345');
      await tester.enterText(confirmPasswordField, 'senha12345');

      // Clicar no botão de cadastro
      await tester.ensureVisible(signUpButton);
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
    'Cadastro inválido com confirmação de senha diferente',
    (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();


      final mockCheckbox = MockCheckbox();
        // Mock the checkbox's value
      when(mockCheckbox.value).thenReturn(true); // Set the checkbox to checked
      
      
      // Construir a tela de cadastro
      await tester.pumpWidget(
          MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth, checkbox: mockCheckbox)));

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
      await tester.ensureVisible(signUpButton);
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

  testWidgets(
    'Cadastro inválido com e-mail já utilizado',
    (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      final mockUser = MockUser();

      final mockCheckbox = MockCheckbox();
        // Mock the checkbox's value
      when(mockCheckbox.value).thenReturn(true); // Set the checkbox to checked

      // Configurar o comportamento simulado do cadastro com erro de e-mail já em uso
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'testexistente@teste.com',
        password: 'senha12345',
      )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.email).thenReturn('testexistente@teste.com');

      await tester.pumpWidget(
          MaterialApp(home: SignUpPage(firebaseAuth: mockFirebaseAuth, checkbox: mockCheckbox)));

      final nameField = find.byKey(const Key('nameField'));
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
      final signUpButton = find.byKey(const Key('signUpButton'));

      await tester.enterText(nameField, 'Testexistente');
      await tester.enterText(emailField, 'testexistente@teste.com');
      await tester.enterText(passwordField, 'senha12345');
      await tester.enterText(confirmPasswordField, 'senha12345');

      // Clicar no botão de cadastro
      await tester.ensureVisible(signUpButton);
      await tester.tap(signUpButton);

      await tester.pump();

      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'testexistente@teste.com',
        password: 'senha12345',
      )).called(1);

      expect(find.text('O email já está em uso'), findsOneWidget);
    },
  );
}

