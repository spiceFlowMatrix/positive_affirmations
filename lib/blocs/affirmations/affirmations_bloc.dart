import 'dart:async';
import 'dart:developer';

import 'package:affirmations_repository_local_storage/affirmations_repository_local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:positive_affirmations/models/affirmation.dart';

part 'affirmations_event.dart';
part 'affirmations_state.dart';

class AffirmationsBloc extends Bloc<AffirmationsEvent, AffirmationsState> {
  final LocalStorageRepository affirmationsRepository;

  AffirmationsBloc({@required this.affirmationsRepository})
      : super(AffirmationsLoadInProgress());

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    if (event is AffirmationsLoaded) {
      yield* _mapAffirmationsLoadedToState();
    } else if (event is AffirmationAdded) {
      yield* _mapAffirmationAddedToState(event);
    }
  }

  Stream<AffirmationsState> _mapAffirmationsLoadedToState() async* {
    try {
      log('Affirmations Loaded');
      final affirmations = await this.affirmationsRepository.loadAffirmations();
      yield AffirmationsLoadSuccess(
        affirmations.map(Affirmation.fromEntity).toList(),
      );
    } catch (e) {
      yield AffirmationsLoadFailure();
    }
  }

  Stream<AffirmationsState> _mapAffirmationAddedToState(
      AffirmationAdded event) async* {
    if (state is AffirmationsLoadSuccess) {
      final List<Affirmation> updatedAffirmations =
          List.from((state as AffirmationsLoadSuccess).affirmations)
            ..add(event.affirmation);
      yield AffirmationsLoadSuccess(updatedAffirmations);
      affirmationsRepository.createAffirmation(event.affirmation.toEntity());
    }
  }
}
