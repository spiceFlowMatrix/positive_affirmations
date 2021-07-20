import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_app/models/machine_date_time.dart';
import 'package:mobile_app/models/models.dart';

part 'affirmations_event.dart';

part 'affirmations_state.dart';

class AffirmationsBloc extends Bloc<AffirmationsEvent, AffirmationsState> {
  AffirmationsBloc({
    required this.authenticatedUser,
    this.time,
  }) : super(AffirmationsState());

  final MachineDateTime? time;
  final User authenticatedUser;

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    if (event is AffirmationCreated) {
      yield _mapAffirmationCreatedToState(event, state);
    } else if (event is AffirmationLiked) {
      yield _mapAffirmationLikedToState(event, state);
    } else if (event is AffirmationActivationToggled) {
      yield _mapAffirmationActivationToggledToState(event, state);
    } else if (event is AffirmationUpdated) {
      yield _mapAffirmationUpdatedToState(event, state);
    }
  }

  AffirmationsState _mapAffirmationCreatedToState(
      AffirmationCreated event, AffirmationsState state) {
    final newAffirmation = Affirmation(
      id: state.affirmations.length + 1,
      title: event.title,
      subtitle: event.subtitle,
      createdById: authenticatedUser.id,
      createdOn: time?.now ?? DateTime.now(),
    );

    final newAffirmations = [
      ...state.affirmations,
      newAffirmation,
    ];

    return state.copyWith(affirmations: newAffirmations);
  }

  AffirmationsState _mapAffirmationLikedToState(
      AffirmationLiked event, AffirmationsState state) {
    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.id
          ? affirmation.copyWith(liked: !affirmation.liked)
          : affirmation;
    }).toList();

    return state.copyWith(affirmations: [...updatedAffirmations]);
  }

  AffirmationsState _mapAffirmationActivationToggledToState(
      AffirmationActivationToggled event, AffirmationsState state) {
    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.id
          ? affirmation.copyWith(active: !affirmation.active)
          : affirmation;
    }).toList();

    return state.copyWith(affirmations: [...updatedAffirmations]);
  }

  AffirmationsState _mapAffirmationUpdatedToState(
      AffirmationUpdated event, AffirmationsState state) {
    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.id
          ? affirmation.copyWith(
              title: event.title,
              subtitle: event.subtitle,
            )
          : affirmation;
    }).toList();

    return state.copyWith(affirmations: [...updatedAffirmations]);
  }
}

class HydratedAffirmationsBloc extends AffirmationsBloc with HydratedMixin {
  HydratedAffirmationsBloc({required User authenticatedUser})
      : super(authenticatedUser: authenticatedUser);

  @override
  AffirmationsState? fromJson(Map<String, dynamic> json) {
    List<Affirmation> affirmations = [
      ...(json[AffirmationsState.fieldAffirmations] as List<dynamic>)
          .map((affirmation) {
        final affirmationJson = affirmation as Map<String, dynamic>;
        return Affirmation.fromJson(affirmationJson);
      }),
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
