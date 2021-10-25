part of 'affirmations_bloc.dart';

class AffirmationsState extends Equatable {
  const AffirmationsState({
    this.affirmations = const [],
    this.loadingStatus = FormzStatus.pure,
    this.loadingError = '',
  });

  final List<Affirmation> affirmations;
  final FormzStatus loadingStatus;
  final String loadingError;

  AffirmationsState copyWith({
    List<Affirmation>? affirmations,
    FormzStatus? loadingStatus,
    String? loadingError,
  }) {
    return AffirmationsState(
      affirmations: affirmations ?? this.affirmations,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingError: loadingError ?? this.loadingError,
    );
  }

  @override
  List<Object> get props => [
        affirmations,
        loadingStatus,
        loadingError,
      ];

  static const String fieldAffirmations = 'affirmations';
  static const String fieldLoadingStatus = 'loadingStatus';
  static const String fieldLoadingError = 'loadingError';
}