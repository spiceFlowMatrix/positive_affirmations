import 'dart:async';

import 'package:app/models/machine_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
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
  }) : super(const AffirmationsState()) {
    on<AffirmationCreated>(_mapAffirmationCreatedToState);
    on<AffirmationLiked>(_mapAffirmationLikedToState);
    on<AffirmationActivationToggled>(_mapAffirmationActivationToggledToState);
    on<AffirmationUpdated>(_mapAffirmationUpdatedToState);
    on<ReaffirmationCreated>(_mapReaffirmationCreatedToState);
    on<AffirmationsLoaded>(_loadAffirmations);
    on<AffirmationsUpdated>(_updateAffirmations);
    on<AffirmationDeleted>(_deleteAffirmation);
  }

  final MachineDateTime? time;
  final UserRepository userRepository;
  final AffirmationsRepository affirmationsRepository;

  // StreamSubscription? _affirmationsSubscription;

  @override
  Future<void> close() {
    // _affirmationsSubscription?.cancel();
    return super.close();
  }

  Future<void> _loadAffirmations(
      AffirmationsLoaded event, Emitter<AffirmationsState> emit) async {
    List<Affirmation> affirmations =
        await affirmationsRepository.getAffirmations(
      userId: event.forUser ? userRepository.currentUser.id : null,
    );
    affirmations = affirmations
        .map((e) => e.copyWith(
            liked: e.likes.any((element) =>
                element.byUserId == userRepository.currentUser.id)))
        .toList();
    emit(state.copyWith(affirmations: affirmations));
  }

  void _updateAffirmations(
      AffirmationsUpdated event, Emitter<AffirmationsState> emit) {
    emit(state.copyWith(affirmations: event.affirmations));
  }

  Future<void> _mapAffirmationCreatedToState(
      AffirmationCreated event, Emitter<AffirmationsState> emit) async {
    final newAffirmation = Affirmation(
      id: const Uuid().v4(),
      title: event.title,
      subtitle: event.subtitle,
      createdById: userRepository.currentUser.id,
      createdOn: time?.now ?? DateTime.now(),
    );
    await affirmationsRepository.saveAffirmation(newAffirmation);
    emit(state.copyWith(affirmations: [
      ...state.affirmations,
      newAffirmation,
    ]));
  }

  Future<void> _mapAffirmationLikedToState(
      AffirmationLiked event, Emitter<AffirmationsState> emit) async {
    final updatedAffirmation = await affirmationsRepository.toggleLiked(
      affirmationId: event.id,
      userId: userRepository.currentUser.id,
    );

    if (updatedAffirmation == null) return;

    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.id ? updatedAffirmation : affirmation;
    }).toList();

    emit(state.copyWith(affirmations: [...updatedAffirmations]));
  }

  Future<void> _mapAffirmationActivationToggledToState(
      AffirmationActivationToggled event,
      Emitter<AffirmationsState> emit) async {
    final updatedAffirmation =
        await affirmationsRepository.toggleActivated(event.id);
    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.id ? updatedAffirmation : affirmation;
    }).toList();

    emit(state.copyWith(affirmations: [...updatedAffirmations]));
  }

  Future<void> _mapAffirmationUpdatedToState(
      AffirmationUpdated event, Emitter<AffirmationsState> emit) async {
    Affirmation? updatedAffirmation =
        await affirmationsRepository.editAffirmation(
      event.id,
      title: event.title,
      subtitle: event.subtitle,
    );
    if (updatedAffirmation == null) return;
    final updatedAffirmations = state.affirmations.map((affirmation) {
      return affirmation.id == event.id ? updatedAffirmation : affirmation;
    }).toList();

    emit(state.copyWith(affirmations: [...updatedAffirmations]));
  }

  Future<void> _mapReaffirmationCreatedToState(
      ReaffirmationCreated event, Emitter<AffirmationsState> emit) async {
    final newReaffirmation = Reaffirmation(
      id: const Uuid().v4(),
      affirmationId: event.affirmationId,
      createdOn: time?.now ?? DateTime.now(),
      value: event.value,
      font: event.font,
      stamp: event.stamp,
    );

    final updatedAffirmation = await affirmationsRepository.createReaffirmation(
      affirmationId: event.affirmationId,
      reaffirmation: newReaffirmation,
    );

    emit(state.copyWith(
      affirmations: [
        ...state.affirmations.map((e) {
          if (e.id == updatedAffirmation.id) {
            return updatedAffirmation;
          } else {
            return e;
          }
        }).toList(),
      ],
    ));
  }

  Future<void> _deleteAffirmation(
      AffirmationDeleted event, Emitter<AffirmationsState> emit) async {
    await affirmationsRepository.deleteAffirmation(event.id);
    List<Affirmation> updatedAffirmations = [...state.affirmations];
    updatedAffirmations.removeWhere((element) => element.id == event.id);
    emit(state.copyWith(
      affirmations: updatedAffirmations,
    ));
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

    return AffirmationsState(
      affirmations: affirmations,
    );
  }

  @override
  Map<String, dynamic>? toJson(AffirmationsState state) => {
        AffirmationsState.fieldAffirmations: [
          ...state.affirmations.map((e) => e.fieldValues),
        ],
      };
}
