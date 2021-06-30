import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/affirmation.dart';

void main() {
  final DateTime mockCreatedOn = DateTime.now();
  late AffirmationsBloc affirmationsBloc;

  setUp(() {
    affirmationsBloc = AffirmationsBloc();
  });

  group('[AffirmationsBloc]', () {
    group('[AffirmationCreated]', () {
      blocTest<AffirmationsBloc, AffirmationsState>(
        'emits updated affirmations list when valid affirmation submitted',
        build: () => affirmationsBloc,
        act: (bloc) {
          bloc
            ..add(new AffirmationCreated('-', '-'))
            ..add(new AffirmationCreated('-', '-'));
        },
        expect: () => <AffirmationsState>[
          AffirmationsState(
            affirmations: [
              ...affirmationsBloc.state.affirmations,
              Affirmation(
                id: affirmationsBloc.state.affirmations.length + 1,
                title: '-',
                createdOn: mockCreatedOn,
              ),
            ],
          ),
          AffirmationsState(
            affirmations: [
              ...PositiveAffirmationsConsts.seedAffirmations,
              Affirmation(
                id: affirmationsBloc.state.affirmations.length + 1,
                title: '-',
                createdOn: mockCreatedOn,
              ),
              Affirmation(
                id: affirmationsBloc.state.affirmations.length + 2,
                title: '-',
                createdOn: mockCreatedOn,
              ),
            ],
          ),
        ],
      );
    });
  });
}
