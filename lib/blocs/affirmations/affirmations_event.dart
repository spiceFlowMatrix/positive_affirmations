part of 'affirmations_bloc.dart';

abstract class AffirmationsEvent extends Equatable {
  const AffirmationsEvent();

  @override
  List<Object> get props => [];
}

class AffirmationsLoaded extends AffirmationsEvent {}

class AffirmationAdded extends AffirmationsEvent {
  final Affirmation affirmation;

  const AffirmationAdded(this.affirmation);

  @override
  List<Object> get props => [affirmation];

  @override
  String toString() => 'AffirmationAdded { affirmation: $affirmation }';
}
