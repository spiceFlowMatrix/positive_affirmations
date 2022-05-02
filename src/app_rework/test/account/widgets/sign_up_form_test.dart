import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/account/widgets/sign_up_form.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';
import 'package:repository/repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockSignUpCubit extends MockCubit<SignUpFormState>
    implements SignUpFormCubit {}

class MockEmail extends Mock implements EmailField {}

class MockPassword extends Mock implements PasswordField {}

void main() {
  const emailInputKey = Key('signUpForm_emailInput_textField');

  const testEmail = 'test@gmail.com';

  group('[SignUpForm]', () {
    late SignUpFormCubit cubit;

    setUp(() {
      cubit = MockSignUpCubit();
      when(() => cubit.state).thenReturn(const SignUpFormState());
      when(() => cubit.submit()).thenAnswer((_) async {});
    });

    group('[Calls]', () {
      testWidgets('emailChanged when email changes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: cubit,
                child: const SignUpForm(),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(emailInputKey), testEmail);
        verify(() => cubit.updateEmail(testEmail)).called(1);
      });
    });

    group('[Renders]', () {
      testWidgets(
        'enabled sign up button when status is validated',
        (WidgetTester tester) async {},
      );
    });
  });
}
