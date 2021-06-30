import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/models/affirmation.dart';
import 'package:mobile_app/models/machine_date_time.dart';
import 'package:mocktail/mocktail.dart';

class MockMachineDateTime extends Mock implements MachineDateTime {}

void main() {
  final DateTime mockTime = DateTime.now();
  late MachineDateTime mockMachineTime;
  late AffirmationsBloc affirmationsBloc;
  late int mockAffirmationsLength;

  setUp(() {
    mockMachineTime = MockMachineDateTime();
    affirmationsBloc = AffirmationsBloc(time: mockMachineTime);
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
            ..add(new AffirmationCreated('-', '-'))
            ..add(new AffirmationCreated('-', '-'));
        },
        expect: () {
          return <AffirmationsState>[
            AffirmationsState(
              affirmations: [
                Affirmation(
                  id: mockAffirmationsLength + 1,
                  title: '-',
                  createdOn: mockTime,
                ),
              ],
            ),
            AffirmationsState(
              affirmations: [
                Affirmation(
                  id: mockAffirmationsLength + 1,
                  title: '-',
                  createdOn: mockTime,
                ),
                Affirmation(
                  id: mockAffirmationsLength + 2,
                  title: '-',
                  createdOn: mockTime,
                ),
              ],
            ),
          ];
        },
      );
    });
  });
}
