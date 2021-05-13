import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/models/models.dart';
import 'package:mobile_app/account_setup/models/name_field.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form_screen.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

class FakeSignUpEvent extends Fake implements SignUpEvent {}

class FakeSignUpState extends Fake implements SignUpState {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockNickNameField extends Mock implements NameField {}

class NickNameFormFixture extends StatelessWidget {
  NickNameFormFixture(this.bloc);

  final SignUpBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: NickNameForm(),
        ),
      ),
    );
  }
}

void main() {
  const mockValidName = 'validName';
  const mockValidNickName = 'validNickName';

  group('[NickNameForm]', () {
    late SignUpBloc signUpBloc;
    setUpAll(() {
      registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
      registerFallbackValue<SignUpState>(FakeSignUpState());
      registerFallbackValue<SignUpBloc>(MockSignUpBloc());
    });

    setUp(() {
      signUpBloc = MockSignUpBloc();
    });

    test('NickName form screen is routable', () {
      expect(NickNameFormScreen.route(signUpBloc), isA<MaterialPageRoute>());
    });

    testWidgets('NickNameForm renders when NameForm is submitted',
        (tester) async {
      when(() => signUpBloc.state).thenReturn(SignUpState(
        name: const NameField.dirty(mockValidName),
        nameStatus: FormzStatus.submissionSuccess,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: NickNameFormScreen(signUpBloc),
        ),
      );

      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameFormScreen),
        findsOneWidget,
      );
    });

    testWidgets('components are rendered', (tester) async {
      await tester.pumpWidget(NickNameFormFixture(signUpBloc));

      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameFieldLabel),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameField),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.changeNameButton),
        findsOneWidget,
      );
    });
  });
}
