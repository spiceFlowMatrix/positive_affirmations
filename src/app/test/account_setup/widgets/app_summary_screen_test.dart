import 'package:app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/account_setup/widgets/app_summary_screen.dart';
import 'package:app/account_setup/widgets/nick_name_form_screen.dart';
import 'package:app/blocs/authentication/authentication_bloc.dart';
import 'package:app/models/models.dart';
import 'package:app/nav_observer.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';

import '../../mocks/authentication_bloc_mock.dart';
import '../../mocks/profile_bloc_mock.dart';
import '../../mocks/sign_up_bloc_mock.dart';
import '../../mocks/user_repository_mock.dart';
import '../fixtures/app_summary_screen_fixture.dart';
import '../fixtures/fixtures.dart';

class MockNameField extends Mock implements NameField {}

void main() {
  const mockValidName = 'validName';
  const mockValidNickName = 'validNickName';
  // const mockInvalidNickName = '35.n\'fwe342-';
  const mockValidSignUpState = SignUpState(
    name: const NameField.dirty(mockValidName),
    nameStatus: FormzStatus.submissionSuccess,
    nickName: const NickNameField.dirty(mockValidNickName),
    nickNameStatus: FormzStatus.submissionSuccess,
  );
  group('[AppSummaryScreen]', () {
    late SignUpBloc signUpBloc;
    late AuthenticationBloc authBloc;
    late ProfileBloc profileBloc;
    late PositiveAffirmationsNavigatorObserver navigatorObserver;
    late UserRepository userRepository;

    setUpAll(() {
      registerFallbackValue<SignUpEvent>(FakeSignUpEvent());
      registerFallbackValue<SignUpState>(FakeSignUpState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<ProfileEvent>(FakeProfileEvent());
      registerFallbackValue<ProfileState>(FakeProfileState());
    });

    setUp(() {
      userRepository = MockUserRepository();
      signUpBloc = MockSignUpBloc();
      authBloc = MockAuthenticationBloc();
      profileBloc = MockProfileBloc();
      navigatorObserver = PositiveAffirmationsNavigatorObserver();
    });

    testWidgets('all components exist', (tester) async {
      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      when(() => signUpBloc.state).thenReturn(mockValidSignUpState);
      await tester.pumpWidget(AppSummaryScreenFixture(
        signUpBloc,
        authBloc: authBloc,
        profileBloc: profileBloc,
      ));

      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryScreen),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryHeader),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummarySubheader),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryUserNameHeader),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.appSummaryAnimatedBody),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.skipAppSummaryButton),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.changeNickNameButton),
        findsOneWidget,
      );
    });

    testWidgets('is routable', (tester) async {
      // Reference https://medium.com/@harsha973/widget-testing-pushing-a-new-page-13cd6a0bb055
      var isNickNameFormPushed = false;
      var isAppSummaryScreenPushed = false;

      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      when(() => signUpBloc.state).thenReturn(const SignUpState(
        name: const NameField.dirty(mockValidName),
        nameStatus: FormzStatus.submissionSuccess,
      ));

      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
        navigatorObserver: navigatorObserver,
        authBloc: authBloc,
      ));
      navigatorObserver.attachPushRouteObserver(
        NickNameFormScreen.routeName,
        () {
          isNickNameFormPushed = true;
        },
      );

      await tester.enterText(
        find.byKey(PositiveAffirmationsKeys.nameField),
        mockValidName,
      );

      await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));

      await tester.pumpAndSettle();

      expect(isNickNameFormPushed, true);

      navigatorObserver.attachPushRouteObserver(
        AppSummaryScreen.routeName,
        () {
          isAppSummaryScreenPushed = true;
        },
      );

      await tester
          .tap(find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton));

      await tester.pumpAndSettle();

      expect(isAppSummaryScreenPushed, true);
    });

    testWidgets('back button works', (tester) async {
      // Reference https://medium.com/@harsha973/widget-testing-pushing-a-new-page-13cd6a0bb055
      var isNickNameFormPushed = false;
      var isAppSummaryScreenPushed = false;
      var isAppSummaryScreenPopped = false;

      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      when(() => signUpBloc.state).thenReturn(const SignUpState(
        name: const NameField.dirty(mockValidName),
        nameStatus: FormzStatus.submissionSuccess,
      ));

      await tester.pumpWidget(NameFormFixture(
        signUpBloc,
        userRepository: userRepository,
        navigatorObserver: navigatorObserver,
        authBloc: authBloc,
      ));
      navigatorObserver.attachPushRouteObserver(
        NickNameFormScreen.routeName,
        () {
          isNickNameFormPushed = true;
        },
      );

      await tester.enterText(
        find.byKey(PositiveAffirmationsKeys.nameField),
        mockValidName,
      );

      await tester.tap(find.byKey(PositiveAffirmationsKeys.nameSubmitButton));

      await tester.pumpAndSettle();

      expect(isNickNameFormPushed, true);

      navigatorObserver.attachPushRouteObserver(
        AppSummaryScreen.routeName,
        () {
          isAppSummaryScreenPushed = true;
        },
      );
      navigatorObserver.attachPopRouteObserver(
        AppSummaryScreen.routeName,
        () {
          isAppSummaryScreenPopped = true;
        },
      );

      await tester
          .tap(find.byKey(PositiveAffirmationsKeys.nickNameSubmitButton));

      await tester.pumpAndSettle();

      expect(isAppSummaryScreenPushed, true);

      await tester
          .tap(find.byKey(PositiveAffirmationsKeys.changeNickNameButton));

      await tester.pumpAndSettle();

      expect(isAppSummaryScreenPopped, true);
    });

    testWidgets('skipping summary screen saves user details', (tester) async {
      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      when(() => signUpBloc.state).thenReturn(mockValidSignUpState);

      await tester.pumpWidget(AppSummaryScreenFixture(
        signUpBloc,
        authBloc: authBloc,
        profileBloc: profileBloc,
      ));

      await tester
          .tap(find.byKey(PositiveAffirmationsKeys.skipAppSummaryButton));

      verify(() => signUpBloc.add(UserSubmitted())).called(1);
    });

    testWidgets('when new user is created, authentication status is changed',
        (tester) async {
      final User createdUser = User(
        id: '23fe3r',
        name: mockValidSignUpState.name.value,
        nickName: mockValidSignUpState.nickName.value,
      );
      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      when(() => signUpBloc.state)
          .thenReturn(mockValidSignUpState.copyWith(createdUser: createdUser));
      when(() => profileBloc.state).thenReturn(ProfileState(user: createdUser));

      final expectedStates = [
        mockValidSignUpState.copyWith(
          submissionStatus: FormzStatus.submissionSuccess,
          createdUser: createdUser,
        ),
      ];

      // Reference for solution https://github.com/felangel/bloc/issues/655
      whenListen(
        signUpBloc,
        Stream.fromIterable(expectedStates),
        initialState: mockValidSignUpState,
      );

      await tester.pumpWidget(AppSummaryScreenFixture(
        signUpBloc,
        authBloc: authBloc,
        profileBloc: profileBloc,
      ));

      // TODO: This test is valid but I need to learn why in tests the auth status changed event is called twice.
      verify(() => authBloc.add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated,
          ))).called(2);
    });
  });
}
