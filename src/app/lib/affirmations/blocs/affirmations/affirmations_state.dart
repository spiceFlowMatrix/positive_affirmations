part of 'affirmations_bloc.dart';

class AffirmationsState extends Equatable {
  const AffirmationsState({
    this.affirmations = const [],
    this.reaffirmations = const [],
    this.loadingStatus = FormzStatus.pure,
    this.loadingError = '',
  });

  final List<Affirmation> affirmations;
  final List<Reaffirmation> reaffirmations;
  final FormzStatus loadingStatus;
  final String loadingError;

  AffirmationsState copyWith({
    List<Affirmation>? affirmations,
    List<Reaffirmation>? reaffirmations,
    FormzStatus? loadingStatus,
    String? loadingError,
  }) {
    return AffirmationsState(
      affirmations: affirmations ?? this.affirmations,
      reaffirmations: reaffirmations ?? this.reaffirmations,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingError: loadingError ?? this.loadingError,
    );
  }

  @override
  List<Object> get props => [
        affirmations,
        reaffirmations,
        loadingStatus,
        loadingError,
      ];

  static const String fieldAffirmations = 'affirmations';
  static const String fieldReaffirmations = 'reaffirmations';
  static const String fieldLoadingStatus = 'loadingStatus';
  static const String fieldLoadingError = 'loadingError';
}