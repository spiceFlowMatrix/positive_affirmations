import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';
import 'package:formz/formz.dart';

class FakeSignUpEvent extends Fake implements SignUpEvent {}

class FakeSignUpState extends Fake implements SignUpState {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockNameField extends Mock implements NameField {}

void main() {
  group('NameFormScreen', () {
    late SignUpBloc signUpBloc;

    setUpAll(() {
      registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
      registerFallbackValue<SignUpState>(FakeSignUpState());
    });

    setUp(() {
      signUpBloc = MockSignUpBloc();
    });

    testWidgets('Components exist by key', (tester) async {
      await tester.pumpWidget(MaterialApp(home: NameFormScreen()));

      expect(find.byKey(PositiveAffirmationsKeys.nameField), findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.nameFieldLabel), findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.nameSubmitButton),
          findsOneWidget);
    });

    testWidgets('Empty form cannot be submitted', (tester) async {
      when(() => signUpBloc.state)
          .thenReturn(const SignUpState(nameStatus: FormzStatus.pure));

      await tester.pumpWidget(MaterialApp(home: NameFormScreen()));

      expect(
        tester
            .widget<ElevatedButton>(
                find.byKey(PositiveAffirmationsKeys.nameSubmitButton))
            .enabled,
        isFalse,
      );
    });

    testWidgets('Error text is rendered when validation errors exist',
        (tester) async {
      final nameField = MockNameField();
      when(() => nameField.error).thenReturn(NameFieldValidationError.invalid);
      when(() => signUpBloc.state).thenReturn(
        SignUpState(
          name: nameField,
          nameStatus: FormzStatus.invalid,
        ),
      );

      await tester.pumpWidget(MaterialApp(home: NameFormScreen()));

      expect(
        tester
            .widget<TextField>(find.byKey(PositiveAffirmationsKeys.nameField))
            .decoration!
            .errorText,
        isNotNull,
      );
    });

    testWidgets('Error text only shows when name field is not pure',
        (tester) async {
      final nameField = MockNameField();
      when(() => nameField.pure).thenReturn(true);
      when(() => signUpBloc.state).thenReturn(SignUpState(name: nameField));

      await tester.pumpWidget(MaterialApp(home: NameFormScreen()));

      expect(
        tester
            .widget<TextField>(find.byKey(PositiveAffirmationsKeys.nameField))
            .decoration!
            .errorText,
        isNull,
      );
    });
  });
}
