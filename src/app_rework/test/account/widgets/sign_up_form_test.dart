import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/account/widgets/sign_in_form_screen.dart';
import 'package:positive_affirmations/account/widgets/sign_up_form.dart';
import 'package:positive_affirmations/account/widgets/sign_up_form_screen.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';
import 'package:repository/repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockSignUpCubit extends MockCubit<SignUpFormState>
    implements SignUpFormCubit {}

class MockEmail extends Mock implements EmailField {}

class MockPassword extends Mock implements PasswordField {}

class SignUpFormFixture extends StatelessWidget {
  const SignUpFormFixture({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SignUpFormCubit cubit;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignUpFormScreen.routeName,
      routes: {
        SignUpFormScreen.routeName: (context) => Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const SignUpForm(),
              ),
            ),
        SignInFormScreen.routeName: (context) => const SignInFormScreen(),
      },
    );
  }
}

void main() {
  const nameInputKey = Key('__signUpForm_nameInput_textField__');
  const nickNameInputKey = Key('__signUpForm_nickNameInput_textField__');
  const emailInputKey = Key('__signUpForm_emailInput_textField__');
  const passwordInputKey = Key('__signUpForm_passwordInput_textField__');
  const confirmPasswordInputKey =
      Key('__signUpForm_confirmPasswordInput_textField__');
  const submitButtonKey = Key('__signUpForm_submit_button__');
  const signInButtonKey = Key('__signUpForm_signIn_button__');

  const testValidEmail = 'test@gmail.com';
  const testValidName = 'Valid Name';
  const testValidNickName = 'nickName';
  const testValidPassword = '1234567As';

  group('[SignUpForm]', () {
    late SignUpFormCubit cubit;

    setUp(() {
      cubit = MockSignUpCubit();
      when(() => cubit.state).thenReturn(const SignUpFormState());
      when(() => cubit.submit()).thenAnswer((_) async {});
    });

    group('[Calls]', () {
      testWidgets(
        '[emailUpdated] triggers when email changes',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );
          final emailInputFinder = find.descendant(
            of: find.byKey(emailInputKey),
            matching: find.byType(TextField),
          );
          await tester.enterText(emailInputFinder, testValidEmail);

          verify(() => cubit.updateEmail(testValidEmail)).called(1);
        },
      );

      testWidgets(
        '[updateName] triggers when name changes',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );
          final nameInputFinder = find.descendant(
            of: find.byKey(nameInputKey),
            matching: find.byType(TextField),
          );
          await tester.enterText(nameInputFinder, testValidName);

          verify(() => cubit.updateName(testValidName)).called(1);
        },
      );

      testWidgets(
        '[updateNickname] triggers when nickName changes',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );
          final nickNameInputFinder = find.descendant(
            of: find.byKey(nickNameInputKey),
            matching: find.byType(TextField),
          );
          await tester.enterText(nickNameInputFinder, testValidNickName);

          verify(() => cubit.updateNickname(testValidNickName)).called(1);
        },
      );

      testWidgets(
        '[passwordUpdated] triggers when password changes',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );
          final passwordInputFinder = find.descendant(
            of: find.byKey(passwordInputKey),
            matching: find.byType(TextField),
          );
          await tester.enterText(passwordInputFinder, testValidPassword);

          verify(() => cubit.updatePassword(testValidPassword)).called(1);
        },
      );

      testWidgets(
        '[confirmPasswordUpdated] triggers when confirmPassword changes',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );
          final confirmPasswordInputFinder = find.descendant(
            of: find.byKey(confirmPasswordInputKey),
            matching: find.byType(TextField),
          );
          await tester.enterText(confirmPasswordInputFinder, testValidPassword);

          verify(() => cubit.updateConfirmPassword(testValidPassword))
              .called(1);
        },
      );

      testWidgets(
        '[submit] triggers when sign up button is pressed',
        (WidgetTester tester) async {
          when(() => cubit.state).thenReturn(const SignUpFormState(
            name: PersonNameField.dirty(testValidName),
            nickName: NullablePersonNameField.dirty(testValidNickName),
            email: EmailField.dirty(testValidEmail),
            password: PasswordField.dirty(testValidPassword),
            confirmPassword: PasswordField.dirty(testValidPassword),
            status: FormzStatus.valid,
          ));
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );

          await tester.tap(find.byKey(submitButtonKey));

          verify(() => cubit.submit()).called(1);
        },
      );
    });

    group('[Renders]', () {
      testWidgets(
        'given form is validated, sign up button is enabled',
        (WidgetTester tester) async {
          when(() => cubit.state).thenReturn(const SignUpFormState(
            name: PersonNameField.dirty(testValidName),
            nickName: NullablePersonNameField.dirty(testValidNickName),
            email: EmailField.dirty(testValidEmail),
            password: PasswordField.dirty(testValidPassword),
            confirmPassword: PasswordField.dirty(testValidPassword),
            status: FormzStatus.valid,
          ));
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );

          final button =
              tester.widget<ElevatedButton>(find.byKey(submitButtonKey));

          expect(button, isNotNull);
          expect(button.enabled, isTrue);
        },
      );

      testWidgets(
        'given passwords do not match, sign up button is disabled',
        (WidgetTester tester) async {
          when(() => cubit.state).thenReturn(const SignUpFormState(
            name: PersonNameField.dirty(testValidName),
            nickName: NullablePersonNameField.dirty(testValidNickName),
            email: EmailField.dirty(testValidEmail),
            password: PasswordField.dirty(testValidPassword),
            confirmPassword: PasswordField.dirty(testValidPassword + 'suffix'),
            status: FormzStatus.valid,
          ));
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );

          final button =
              tester.widget<ElevatedButton>(find.byKey(submitButtonKey));

          expect(button, isNotNull);
          expect(button.enabled, isFalse);
        },
      );
    });

    // Navigation tests adapted from:
    // https://github.com/felangel/bloc/blob/b4c8db938ad71a6b60d4a641ec357905095c3965/examples/flutter_firebase_login/test/sign_up/view/sign_up_form_test.dart#L238
    group('[Navigates]', () {
      testWidgets(
        'navigates to sign in screen when sign in button tapped',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            SignUpFormFixture(cubit: cubit),
          );

          expect(find.byType(SignUpForm), findsOneWidget);
          expect(find.byType(SignInFormScreen), findsNothing);
          await tester.tap(find.byKey(signInButtonKey));
          await tester.pumpAndSettle();
          expect(find.byType(SignUpForm), findsNothing);
          expect(find.byType(SignInFormScreen), findsOneWidget);
        },
      );
    });
  });
}
