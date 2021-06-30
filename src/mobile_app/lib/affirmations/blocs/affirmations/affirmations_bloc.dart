import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_app/models/machine_date_time.dart';
import 'package:mobile_app/models/models.dart';

part 'affirmations_event.dart';

part 'affirmations_state.dart';

class AffirmationsBloc extends Bloc<AffirmationsEvent, AffirmationsState> {
  AffirmationsBloc({this.time}) : super(AffirmationsState());

  final MachineDateTime? time;

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    if (event is AffirmationCreated) {
      yield _mapAffirmationCreatedToState(event, state);
    }
  }

  AffirmationsState _mapAffirmationCreatedToState(
      AffirmationCreated event, AffirmationsState state) {
    final newAffirmation = Affirmation(
      id: state.affirmations.length + 1,
      title: event.title,
      createdOn: time?.now ?? DateTime.now(),
    );

    final newAffirmations = [
      ...state.affirmations,
      newAffirmation,
    ];

    return state.copyWith(affirmations: newAffirmations);
  }

// @override
// AffirmationsState? fromJson(Map<String, dynamic> json) {
//   List<Affirmation> affirmations = [
//     ...json[AffirmationsState.fieldAffirmations] as List<Affirmation>
//   ];
//
//   return AffirmationsState(affirmations: affirmations);
// }
//
// @override
// Map<String, dynamic>? toJson(AffirmationsState state) => {
//       AffirmationsState.fieldAffirmations: [
//         ...state.affirmations.map((e) => e.fieldValues),
//       ],
//     };
}
