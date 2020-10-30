part of 'affirmations_bloc.dart';

abstract class AffirmationsEvent extends Equatable {
  const AffirmationsEvent();

  @override
  List<Object> get props => [];
}

class AffirmationsLoaded extends AffirmationsEvent {}
