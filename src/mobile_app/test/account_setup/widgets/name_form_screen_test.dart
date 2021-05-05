import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class NameFormFixture extends StatelessWidget {
  NameFormFixture(this.bloc);

  final SignUpBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: NameForm(),
        ),
      ),
    );
  }
}

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
      await tester.pumpWidget(NameFormFixture(signUpBloc));

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
      when(() => nameField.pure).thenReturn(false);
      when(() => nameField.invalid).thenReturn(true);
      when(() => nameField.error).thenReturn(NameFieldValidationError.invalid);
      when(() => signUpBloc.state).thenReturn(
        SignUpState(
          name: nameField,
          nameStatus: FormzStatus.invalid,
        ),
      );
      await tester.pumpWidget(NameFormFixture(signUpBloc));

      expect(
        tester
            .widget<TextField>(find.byKey(PositiveAffirmationsKeys.nameField))
            .decoration!
            .errorText,
        isA<String>(),
      );
    });

    testWidgets('Error text only shows when name field is not pure',
        (tester) async {
      final nameField = MockNameField();
      when(() => nameField.pure).thenReturn(true);
      when(() => nameField.invalid).thenReturn(false);
      when(() => nameField.error).thenReturn(NameFieldValidationError.empty);
      when(() => signUpBloc.state).thenReturn(SignUpState(name: nameField));

      await tester.pumpWidget(NameFormFixture(signUpBloc));

      expect(
        tester
            .widget<TextField>(find.byKey(PositiveAffirmationsKeys.nameField))
            .decoration!
            .errorText,
        isNull,
      );
    });

    testWidgets('Form is wired to bloc', (tester) async {
      final String nameValue = 'my name';
      when(() => signUpBloc.state).thenReturn(const SignUpState());
      await tester.pumpWidget(NameFormFixture(signUpBloc));

      await tester.enterText(
        find.byKey(PositiveAffirmationsKeys.nameField),
        nameValue,
      );

      verify(() => signUpBloc.add(NameUpdated(nameValue))).called(1);
    });

    group('Form is wired to bloc', () {
      testWidgets('Bloc event is triggered when updating name', (tester) async {
        final String nameValue = 'my name';
        when(() => signUpBloc.state).thenReturn(const SignUpState());
        await tester.pumpWidget(NameFormFixture(signUpBloc));

        await tester.enterText(
          find.byKey(PositiveAffirmationsKeys.nameField),
          nameValue,
        );

        verify(() => signUpBloc.add(NameUpdated(nameValue))).called(1);
      });
      testWidgets('Bloc event is triggered when pressing submit',
          (tester) async {
        when(() => signUpBloc.state)
            .thenReturn(const SignUpState(nameStatus: FormzStatus.valid));
        await tester.pumpWidget(NameFormFixture(signUpBloc));

        await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));

        verify(() => signUpBloc.add(NameSubmitted())).called(1);
      });
    });
  });
}
