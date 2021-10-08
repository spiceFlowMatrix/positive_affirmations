import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/affirmations/blocs/apptab/apptab_bloc.dart';

void main() {
  late ApptabBloc apptabBloc;

  setUp(() {
    apptabBloc = ApptabBloc();
  });

  group('[ApptabBloc]', () {
    test('initial state is [AppTab.affirmations]', () {
      expect(apptabBloc.state, equals(AppTab.affirmations));
    });

    group('[TabUpdated]', () {
      blocTest<ApptabBloc, AppTab>(
        'does not emit updated tab if same as current tab',
        build: () => apptabBloc,
        act: (bloc) {
          bloc
            // Initial state is `AppTab.affirmations` so no need to add that
            ..add(const TabUpdated(AppTab.affirmations))
            ..add(const TabUpdated(AppTab.profile))
            ..add(const TabUpdated(AppTab.profile));
        },
        expect: () => const <AppTab>[
          AppTab.profile,
        ],
      );
      blocTest<ApptabBloc, AppTab>(
        'emits new tab when new tab is updated',
        build: () => apptabBloc,
        act: (bloc) {
          bloc
            ..add(const TabUpdated(AppTab.profile))
            ..add(const TabUpdated(AppTab.affirmations));
        },
        expect: () => const <AppTab>[
          AppTab.profile,
          AppTab.affirmations,
        ],
      );
    });
  });
}
