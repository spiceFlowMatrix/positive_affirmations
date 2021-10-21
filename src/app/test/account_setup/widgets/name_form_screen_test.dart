import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/models/models.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';

import '../../mocks/sign_up_bloc_mock.dart';
import '../../mocks/user_repository_mock.dart';
import '../fixtures/fixtures.dart';

class MockNameField extends Mock implements NameField {}

void main() {
  const mockInvalidName = '35.n\'fwe342-';
  group('[NameFormScreen]', () {
    late SignUpBloc signUpBloc;
    late UserRepository userRepository;

    setUpAll(() {
      registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
      registerFallbackValue<SignUpState>(FakeSignUpState());
    });

    setUp(() {
      userRepository = MockUserRepository();
      signUpBloc = MockSignUpBloc();
    });

    testWidgets('Components exist by key', (tester) async {
      when(() => signUpBloc.state).thenReturn(const SignUpState());
      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
      ));

      expect(find.byKey(PositiveAffirmationsKeys.nameField), findsOneWidget);
      expect(
          find.byKey(PositiveAffirmationsKeys.nameFieldLabel), findsOneWidget);
      expect(find.byKey(PositiveAffirmationsKeys.nameSubmitButton),
          findsOneWidget);
    });

    testWidgets('Empty form cannot be submitted', (tester) async {
      when(() => signUpBloc.state)
          .thenReturn(const SignUpState(nameStatus: FormzStatus.pure));
      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
      ));

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
      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
      ));

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

      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
      ));

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
      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
      ));

      await tester.enterText(
        find.byKey(PositiveAffirmationsKeys.nameField),
        nameValue,
      );

      verify(() => signUpBloc.add(NameUpdated(nameValue))).called(1);
    });

    // testWidgets('navigates to nickName form upon successful form submission',
    //     (tester) async {
    //   when(() => signUpBloc.state).thenReturn(
    //       const SignUpState(nameStatus: FormzStatus.submissionSuccess));
    //
    //   await tester.pumpWidget(NameFormFixture(signUpBloc));
    //
    //   await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));
    //
    //   await tester.pumpAndSettle();
    //
    //   expect(
    //     find.byKey(PositiveAffirmationsKeys.nickNameFormScreen),
    //     findsOneWidget,
    //   );
    // });

    group('[FormWiredToBloc]', () {
      testWidgets('Bloc event is triggered when updating name', (tester) async {
        final String nameValue = 'my name';
        when(() => signUpBloc.state).thenReturn(const SignUpState());
        await tester.pumpWidget(NameFormFixture(
          signUpBloc,
          userRepository: userRepository,
        ));

        await tester.enterText(
          find.byKey(PositiveAffirmationsKeys.nameField),
          nameValue,
        );

        verify(() => signUpBloc.add(NameUpdated(nameValue))).called(1);
      });

      testWidgets('Bloc event is triggered when pressing submit on valid form',
          (tester) async {
        when(() => signUpBloc.state)
            .thenReturn(const SignUpState(nameStatus: FormzStatus.valid));
        await tester.pumpWidget(NameFormFixture(
          signUpBloc,
          userRepository: userRepository,
        ));

        await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));

        verify(() => signUpBloc.add(const NameSubmitted())).called(1);
      });

      testWidgets('submit button is disabled when form is invalid',
          (tester) async {
        when(() => signUpBloc.state).thenReturn(const SignUpState(
          name: NameField.dirty(mockInvalidName),
          nameStatus: FormzStatus.invalid,
        ));

        await tester.pumpWidget(NameFormFixture(
          signUpBloc,
          userRepository: userRepository,
        ));

        expect(
          tester
              .widget<ElevatedButton>(
                  find.byKey(PositiveAffirmationsKeys.nameSubmitButton))
              .enabled,
          isFalse,
        );
      });
    });
  });
}
