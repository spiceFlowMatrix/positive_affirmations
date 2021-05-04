import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/app.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class FakeAuthenticationState extends Fake implements AuthenticationState {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  group('Main Application', () {
    late MockAuthenticationBloc authenticationBloc;

    setUpAll(() {
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    });

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
    });

    test('2. Name form screen is routable', () {
      expect(NameFormScreen.route(), isA<MaterialPageRoute>());
    });

    testWidgets('1. Name form screen is rendered when unauthenticated',
        (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      await tester.pumpWidget(
        BlocProvider<AuthenticationBloc>(
          create: (_) => authenticationBloc,
          child: AppView(),
        ),
      );

      expect(find.byKey(PositiveAffirmationsKeys.nameFormScreen), findsOneWidget);
    });
  });
}
