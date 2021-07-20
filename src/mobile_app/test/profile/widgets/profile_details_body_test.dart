import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/affirmations_bloc_mock.dart';
import '../../mocks/authentication_bloc_mock.dart';
import '../fixtures/profile_details_body_fixture.dart';

void main() {
  final mockUser = PositiveAffirmationsConsts.seedUser;
  final mockAffirmations = PositiveAffirmationsConsts.seedAffirmations;

  late AffirmationsBloc affirmationsBloc;
  late AuthenticationBloc authBloc;

  group('[ProfileDetailsBody]', () {
    setUpAll(() {
      registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
      registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    });

    setUp(() {
      affirmationsBloc = MockAffirmationsBloc();
      authBloc = MockAuthenticationBloc();

      when(() => authBloc.state)
          .thenReturn(AuthenticationState.authenticated(mockUser));

      when(() => affirmationsBloc.authenticatedUser).thenReturn(mockUser);
    });

    testWidgets('all widgets are composed', (tester) async {
      await tester.pumpWidget(ProfileDetailsBodyFixture(
        affirmationsBloc: affirmationsBloc,
        authBloc: authBloc,
      ));
    });
  });
}
