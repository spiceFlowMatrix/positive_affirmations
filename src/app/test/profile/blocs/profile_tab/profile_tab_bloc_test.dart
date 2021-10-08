import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/profile/blocs/profile_tab/profile_tab_bloc.dart';

void main() {
  late ProfileTabBloc profileTabBloc;

  setUp(() {
    profileTabBloc = ProfileTabBloc();
  });

  group('[ProfileTabBloc]', () {
    test('initial tab is affirmations', () {
      expect(profileTabBloc.state, equals(ProfileTab.affirmations));
    });

    group('[TabUpdated]', () {
      blocTest<ProfileTabBloc, ProfileTab>(
        'does not emit new state if same as current tab',
        build: () => profileTabBloc,
        act: (bloc) {
          bloc
            ..add(const TabUpdated(ProfileTab.affirmations))
            ..add(const TabUpdated(ProfileTab.letters))
            ..add(const TabUpdated(ProfileTab.letters));
        },
        expect: () => <ProfileTab>[
          ProfileTab.letters,
        ],
      );
      blocTest<ProfileTabBloc, ProfileTab>(
        'emits new state when new tab is supplied',
        build: () => profileTabBloc,
        act: (bloc) {
          bloc
            ..add(const TabUpdated(ProfileTab.letters))
            ..add(const TabUpdated(ProfileTab.affirmations));
        },
        expect: () => <ProfileTab>[
          ProfileTab.letters,
          ProfileTab.affirmations,
        ],
      );
    });
  });
}
