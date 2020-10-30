import 'dart:async';

import 'package:affirmations_repository_local_storage/affirmations_repository_local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:positive_affirmations/models/affirmation.dart';

part 'affirmations_event.dart';
part 'affirmations_state.dart';

class AffirmationsBloc extends Bloc<AffirmationsEvent, AffirmationsState> {
  final LocalStorageRepository affirmationsRepository;

  AffirmationsBloc(@required this.affirmationsRepository)
      : super(AffirmationsLoadInProgress());

  @override
  Stream<AffirmationsState> mapEventToState(
    AffirmationsEvent event,
  ) async* {
    if (event is AffirmationsLoaded) {
      yield* _mapAffirmationsLoadedToState();
    }
  }

  Stream<AffirmationsState> _mapAffirmationsLoadedToState() async* {
    try {
      final affirmations = await this.affirmationsRepository.loadAffirmations();
      yield AffirmationsLoadSuccess(
        affirmations.map(Affirmation.fromEntity).toList(),
      );
    } catch (e) {
      yield AffirmationsLoadFailure();
    }
  }
}
