part of 'affirmations_list_bloc.dart';

abstract class AffirmationsListState extends Equatable {
  const AffirmationsListState();
}

class AffirmationsListLoadInProgress extends AffirmationsListState {
  @override
  List<Object> get props => [];
}

class AffirmationsListLoadSuccess extends AffirmationsListState {
  const AffirmationsListLoadSuccess({
    this.totalAffirmations = 0,
    this.affirmations = const [],
  });

  final int totalAffirmations;
  final List<Affirmation> affirmations;

  AffirmationsListLoadSuccess copyWith({
    List<Affirmation>? affirmations,
    int? totalAffirmations,
  }) {
    return AffirmationsListLoadSuccess(
      affirmations: affirmations ?? this.affirmations,
      totalAffirmations: totalAffirmations ?? this.totalAffirmations,
    );
  }

  @override
  List<Object> get props => [affirmations, totalAffirmations];
}

class AffirmationsListLoadFailure extends AffirmationsListState {
  const AffirmationsListLoadFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
