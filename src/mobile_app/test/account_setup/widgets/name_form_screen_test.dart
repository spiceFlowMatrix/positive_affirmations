import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

class FakeSignUpEvent extends Fake implements SignUpEvent {}

class FakeSignUpState extends Fake implements SignUpState {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

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
  });
}
