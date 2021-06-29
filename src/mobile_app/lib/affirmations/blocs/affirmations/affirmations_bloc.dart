import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_app/models/models.dart';

part 'affirmations_event.dart';

part 'affirmations_state.dart';

class AffirmationsBloc
    extends HydratedBloc<AffirmationsEvent, AffirmationsState> {
  AffirmationsBloc() : super(AffirmationsState());

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  @override
  AffirmationsState? fromJson(Map<String, dynamic> json) {
    List<Affirmation> affirmations = [
      ...json[AffirmationsState.fieldAffirmations] as List<Affirmation>
    ];

    return AffirmationsState(affirmations: affirmations);
  }

  @override
  Map<String, dynamic>? toJson(AffirmationsState state) => {
        AffirmationsState.fieldAffirmations: [
          ...state.affirmations.map((e) => e.fieldValues),
        ],
      };
}
