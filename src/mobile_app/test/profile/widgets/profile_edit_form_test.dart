import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/models.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/profile_bloc_mock.dart';
import '../../mocks/profile_edit_bloc_mock.dart';
import '../fixtures/profile_edit_form_fixture.dart';

void main() {
  late ProfileEditBloc profileEditBloc;
  late ProfileBloc profileBloc;

  const mockUser = PositiveAffirmationsConsts.seedUser;

  group('[ProfileEditForm]', () {
    setUpAll(() {
      registerFallbackValue<ProfileEditEvent>(FakeProfileEditEvent());
      registerFallbackValue<ProfileEditState>(FakeProfileEditState());
      registerFallbackValue<ProfileEvent>(FakeProfileEvent());
      registerFallbackValue<ProfileState>(FakeProfileState());
    });

    setUp(() {
      profileBloc = MockProfileBloc();
      when(() => profileBloc.state).thenReturn(ProfileState(user: mockUser));
      profileEditBloc = MockProfileEditBloc();
      when(() => profileEditBloc.profileBloc).thenReturn(profileBloc);
      when(() => profileEditBloc.state).thenReturn(ProfileEditState(
        name: NameField.dirty(mockUser.name),
        nickName: NickNameField.dirty(mockUser.nickName),
        status: FormzStatus.pure,
      ));
    });

    testWidgets('all components are composed', (tester) async {
      await tester.pumpWidget(ProfileEditFormFixture(
        profileBloc: profileBloc,
        profileEditBloc: profileEditBloc,
      ));

      expect(
        find.byKey(PositiveAffirmationsKeys.profileEditScreen),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.profileEditScreenTitle),
        findsOneWidget,
      );
      expect(
        find.byKey(PositiveAffirmationsKeys.profileEditForm(mockUser.id)),
        findsOneWidget,
      );

      // Reference https://stackoverflow.com/a/41153547/5472560
      expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.key == PositiveAffirmationsKeys.profileEditNameFieldLabel &&
            widget.data ==
                PositiveAffirmationsConsts.profileEditNameFieldLabel),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) =>
            widget is TextField &&
            widget.key ==
                PositiveAffirmationsKeys.profileEditNameField(mockUser.id) &&
            widget.controller!.value.text == mockUser.name),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.key ==
                PositiveAffirmationsKeys.profileEditNickNameFieldLabel &&
            widget.data ==
                PositiveAffirmationsConsts.profileEditNickNameFieldLabel),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) =>
            widget is TextField &&
            widget.key ==
                PositiveAffirmationsKeys.profileEditNickNameField(
                    mockUser.id) &&
            widget.controller!.value.text == mockUser.nickName),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ElevatedButton &&
              widget.key ==
                  PositiveAffirmationsKeys.profileEditSaveButton(mockUser.id),
        ),
        findsOneWidget,
      );
    });
  });
}
