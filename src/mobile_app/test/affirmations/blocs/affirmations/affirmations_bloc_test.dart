import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
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
          bloc..add(new AffirmationCreated('-', '-'));
        },
        expect: () => <AffirmationsState>[
          AffirmationsState(affirmations: [Affirmation(id: 1, title: '-', createdOn: mockCreatedOn)]),
        ],
      );
    });
  });
}
