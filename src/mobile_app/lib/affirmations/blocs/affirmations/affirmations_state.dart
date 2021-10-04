part of 'affirmations_bloc.dart';

class AffirmationsState extends Equatable {
  const AffirmationsState({
    this.affirmations = const [],
    this.reaffirmations = const [],
  });

  final List<Affirmation> affirmations;
  final List<Reaffirmation> reaffirmations;

  AffirmationsState copyWith({
    List<Affirmation>? affirmations,
    List<Reaffirmation>? reaffirmations,
  }) {
    return AffirmationsState(
      affirmations: affirmations ?? this.affirmations,
      reaffirmations: reaffirmations ?? this.reaffirmations,
    );
  }

  @override
  List<Object> get props => [affirmations, reaffirmations];

  static const String fieldAffirmations = 'affirmations';
  static const String fieldReaffirmations = 'reaffirmations';
}
