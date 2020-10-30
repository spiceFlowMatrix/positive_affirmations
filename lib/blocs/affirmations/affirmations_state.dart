part of 'affirmations_bloc.dart';

abstract class AffirmationsState extends Equatable {
  const AffirmationsState();

  @override
  List<Object> get props => [];
}

class AffirmationsLoadInProgress extends AffirmationsState {}

class AffirmationsLoadSuccess extends AffirmationsState {
  final List<Affirmation> affirmations;

  const AffirmationsLoadSuccess([this.affirmations = const []]);

  @override
  List<Object> get props => [affirmations];

  @override
  String toString() =>
      'AffirmationsLoadSuccess { affirmations: $affirmations }';
}

class AffirmationsLoadFailure extends AffirmationsState {}
