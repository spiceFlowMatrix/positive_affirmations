import 'dart:async';

import 'package:app/models/machine_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';
import 'package:uuid/uuid.dart';

part 'affirmations_event.dart';

part 'affirmations_state.dart';

class AffirmationsBloc extends Bloc<AffirmationsEvent, AffirmationsState> {
  AffirmationsBloc({
    required this.userRepository,
    required this.affirmationsRepository,
    this.time,
  }) : super(const AffirmationsState());

  final MachineDateTime? time;
  final UserRepository userRepository;
  final AffirmationsRepository affirmationsRepository;

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    if (event is AffirmationCreated) {
      yield* _mapAffirmationCreatedToState(event, state);
    } else if (event is AffirmationLiked) {
      yield _mapAffirmationLikedToState(event, state);
    } else if (event is AffirmationActivationToggled) {
      yield _mapAffirmationActivationToggledToState(event, state);
    } else if (event is AffirmationUpdated) {
      yield _mapAffirmationUpdatedToState(event, state);
    } else if (event is ReaffirmationCreated) {
      yield _mapReaffirmationCreatedToState(event, state);
    }
  }

  Stream<AffirmationsState> _mapAffirmationCreatedToState(
      AffirmationCreated event, AffirmationsState state) async* {
    final newAffirmation = Affirmation(
      id: const Uuid().v4(),
      title: event.title,
      subtitle: event.subtitle,
      createdById: userRepository.currentUser.id,
      createdOn: time?.now ?? DateTime.now(),
    );
    await affirmationsRepository.saveAffirmation(newAffirmation);

    final newAffirmations = [
      ...state.affirmations,
      newAffirmation,
    ];

    yield state.copyWith(affirmations: newAffirmations);
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

  AffirmationsState _mapReaffirmationCreatedToState(
      ReaffirmationCreated event, AffirmationsState state) {
    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.affirmationId
          ? affirmation.copyWith(
              totalReaffirmations: affirmation.totalReaffirmations + 1)
          : affirmation;
    });
    final newReaffirmation = new Reaffirmation(
      id: state.reaffirmations.length + 1,
      affirmationId: event.affirmationId,
      createdOn: time?.now ?? DateTime.now(),
      value: event.value,
      font: event.font,
      stamp: event.stamp,
    );

    return state.copyWith(
      affirmations: [...updatedAffirmations],
      reaffirmations: [...state.reaffirmations, newReaffirmation],
    );
  }
}

class HydratedAffirmationsBloc extends AffirmationsBloc with HydratedMixin {
  HydratedAffirmationsBloc({
    required UserRepository userRepository,
    required AffirmationsRepository affirmationsRepository,
  }) : super(
          userRepository: userRepository,
          affirmationsRepository: affirmationsRepository,
        );

  @override
  AffirmationsState? fromJson(Map<String, dynamic> json) {
    List<Affirmation> affirmations = [
      ...(json[AffirmationsState.fieldAffirmations] as List<dynamic>)
          .map((affirmation) {
        final affirmationJson = affirmation as Map<String, dynamic>;
        return Affirmation.fromJson(affirmationJson);
      }),
    ];
    List<Reaffirmation> reaffirmations = [];
    if (json[AffirmationsState.fieldReaffirmations] != null) {
      reaffirmations = [
        ...(json[AffirmationsState.fieldReaffirmations] as List<dynamic>)
            .map((reaffirmation) {
          final reaffirmationJson = reaffirmation as Map<String, dynamic>;
          return Reaffirmation.fromJson(reaffirmationJson);
        })
      ];
    }

    return AffirmationsState(
      affirmations: affirmations,
      reaffirmations: reaffirmations,
    );
  }

  @override
  Map<String, dynamic>? toJson(AffirmationsState state) => {
        AffirmationsState.fieldAffirmations: [
          ...state.affirmations.map((e) => e.fieldValues),
        ],
        AffirmationsState.fieldReaffirmations: [
          ...state.reaffirmations.map((e) => e.fieldValues),
        ],
      };
}
