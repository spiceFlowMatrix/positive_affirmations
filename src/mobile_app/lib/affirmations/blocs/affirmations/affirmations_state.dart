part of 'affirmations_bloc.dart';

class AffirmationsState extends Equatable {
  const AffirmationsState({
    this.affirmations = const [],
  });

  final List<Affirmation> affirmations;

  AffirmationsState copyWith({
    List<Affirmation>? affirmations,
  }) {
    return AffirmationsState(
      affirmations: affirmations ?? this.affirmations,
    );
  }

  @override
  List<Object> get props => [affirmations];

  static const String fieldAffirmations = 'affirmations';
}
