import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/models/machine_date_time.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/models/affirmation.dart';

class MockMachineDateTime extends Mock implements MachineDateTime {}

void main() {
  final DateTime mockTime = DateTime.now();
  late MachineDateTime mockMachineTime;
  late AffirmationsBloc affirmationsBloc;
  late int mockAffirmationsLength;
  late List<Affirmation> seedAffirmations;

  const String validTitle = 'valid title';
  const String validSubtitle = 'valid sub title';

  final String updatedTitle = 'updatedTitle';
  final String updatedSubtitle = 'updatedSubtitle';

  setUp(() {
    seedAffirmations = [
      ...PositiveAffirmationsRepositoryConsts.seedAffirmations
    ];
    mockMachineTime = MockMachineDateTime();
    affirmationsBloc = AffirmationsBloc(
      time: mockMachineTime,
      authenticatedUser: PositiveAffirmationsRepositoryConsts.seedUser,
    );
    mockAffirmationsLength = affirmationsBloc.state.affirmations.length;
    when(() => mockMachineTime.now).thenReturn(mockTime);
  });

  group('[AffirmationsBloc]', () {
    group('[AffirmationCreated]', () {
      blocTest<AffirmationsBloc, AffirmationsState>(
        'emits updated affirmations list when valid affirmation submitted',
        build: () => affirmationsBloc,
        act: (bloc) {
          bloc
            ..add(new AffirmationCreated(validTitle, validSubtitle))
            ..add(new AffirmationCreated('$validTitle 2', '$validSubtitle 2'));
        },
        expect: () {
          return <AffirmationsState>[
            AffirmationsState(
              affirmations: [
                Affirmation(
                  id: mockAffirmationsLength + 1,
                  title: validTitle,
                  subtitle: validSubtitle,
                  createdById: PositiveAffirmationsRepositoryConsts.seedUser.id,
                  createdOn: mockTime,
                ),
              ],
            ),
            AffirmationsState(
              affirmations: [
                Affirmation(
                  id: mockAffirmationsLength + 1,
                  title: validTitle,
                  subtitle: validSubtitle,
                  createdById: PositiveAffirmationsRepositoryConsts.seedUser.id,
                  createdOn: mockTime,
                ),
                Affirmation(
                  id: mockAffirmationsLength + 2,
                  title: '$validTitle 2',
                  subtitle: '$validSubtitle 2',
                  createdById: PositiveAffirmationsRepositoryConsts.seedUser.id,
                  createdOn: mockTime,
                ),
              ],
            ),
          ];
        },
      );
    });

    group('[AffirmationLiked]', () {
      blocTest<AffirmationsBloc, AffirmationsState>(
        'valid state is emitted',
        build: () => affirmationsBloc,
        seed: () => AffirmationsState(affirmations: seedAffirmations),
        act: (bloc) {
          bloc..add(AffirmationLiked(seedAffirmations[1].id));
        },
        expect: () {
          final updatedAffirmations = seedAffirmations.map((e) {
            return e.id == 2 ? e.copyWith(liked: !e.liked) : e;
          }).toList();
          return <AffirmationsState>[
            AffirmationsState(
              affirmations: [...updatedAffirmations],
            )
          ];
        },
      );
    });

    group('[AffirmationActivationToggled]', () {
      blocTest<AffirmationsBloc, AffirmationsState>(
        'valid state is emitted',
        build: () => affirmationsBloc,
        seed: () => AffirmationsState(affirmations: seedAffirmations),
        act: (bloc) {
          bloc..add(AffirmationActivationToggled(seedAffirmations[1].id));
        },
        expect: () {
          final updatedAffirmations = seedAffirmations.map((e) {
            return e.id == 2 ? e.copyWith(active: !e.active) : e;
          }).toList();
          return <AffirmationsState>[
            AffirmationsState(
              affirmations: [...updatedAffirmations],
            )
          ];
        },
      );
    });

    group('[AffirmationUpdated]', () {
      blocTest<AffirmationsBloc, AffirmationsState>(
        'updated affirmation is emitted in list when valid values are supplied',
        build: () => affirmationsBloc,
        seed: () => AffirmationsState(affirmations: seedAffirmations),
        act: (bloc) {
          bloc
            ..add(AffirmationUpdated(
              seedAffirmations[1].id,
              updatedTitle,
              updatedSubtitle,
            ));
        },
        expect: () {
          final updatedAffirmations = seedAffirmations.map((e) {
            return e.id == 2
                ? e.copyWith(
                    title: updatedTitle,
                    subtitle: updatedSubtitle,
                  )
                : e;
          }).toList();
          return <AffirmationsState>[
            AffirmationsState(
              affirmations: [...updatedAffirmations],
            )
          ];
        },
      );
      blocTest<AffirmationsBloc, AffirmationsState>(
        'supplying exact values as the current state does not emit new state',
        build: () => affirmationsBloc,
        seed: () => AffirmationsState(affirmations: seedAffirmations),
        act: (bloc) {
          bloc
            ..add(AffirmationUpdated(
              seedAffirmations[1].id,
              seedAffirmations[1].title,
              seedAffirmations[1].subtitle,
            ));
        },
        expect: () => <AffirmationsState>[],
      );
    });

    group('[ReaffirmationCreated]', () {
      blocTest<AffirmationsBloc, AffirmationsState>(
        'reaffirmation is added to state list',
        build: () => affirmationsBloc,
        seed: () => AffirmationsState(affirmations: seedAffirmations),
        act: (bloc) {
          bloc
            ..add(ReaffirmationCreated(
              affirmationId: seedAffirmations[1].id,
              value: ReaffirmationValue.loveIt,
              font: ReaffirmationFont.montserrat,
              stamp: ReaffirmationStamp.takeOff,
            ));
        },
        expect: () {
          final updatedAffirmations = seedAffirmations.map((e) {
            if (e.id == seedAffirmations[1].id) {
              return e.copyWith(totalReaffirmations: e.totalReaffirmations + 1);
            }
            return e;
          }).toList();

          return <AffirmationsState>[
            AffirmationsState(
              affirmations: updatedAffirmations,
              reaffirmations: [
                Reaffirmation(
                  id: 1,
                  affirmationId: seedAffirmations[1].id,
                  createdOn: mockTime,
                  value: ReaffirmationValue.loveIt,
                  font: ReaffirmationFont.montserrat,
                  stamp: ReaffirmationStamp.takeOff,
                ),
              ],
            ),
          ];
        },
      );
    });
  });
}
