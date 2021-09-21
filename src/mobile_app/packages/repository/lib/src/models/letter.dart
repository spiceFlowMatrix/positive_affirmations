import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/models/reaffirmation.dart';

class Letter extends Equatable {
  Letter({
    required this.id,
    required this.affirmation,
    required this.reaffirmations,
    required this.createdOn,
    this.opened = false,
  });

  final int id;
  final Affirmation affirmation;
  final List<Reaffirmation> reaffirmations;
  final DateTime createdOn;
  final bool opened;

  static final empty = Letter(
    id: 0,
    affirmation: Affirmation.empty,
    reaffirmations: [],
    createdOn: DateTime.utc(0),
  );

  static const String fieldId = 'id';
  static const String fieldAffirmation = 'affirmation';
  static const String fieldReaffirmations = 'reaffirmations';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldOpened = 'opened';

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldAffirmation: this.affirmation,
        fieldReaffirmations: [...this.reaffirmations.map((e) => e.fieldValues)],
        fieldCreatedOn: this.createdOn,
        fieldOpened: this.opened,
      };

  static Letter fromJson(Map<String, dynamic> json) {
    List<Reaffirmation> reaffirmations = [];
    if (json[Letter.fieldReaffirmations]) {
      final reaffirmationsJson =
          json[Letter.fieldReaffirmations] as List<dynamic>;
      reaffirmationsJson.forEach((element) {
        reaffirmations.add(Reaffirmation.fromJson(element));
      });
    }
    return Letter(
        id: json[Letter.fieldId] ?? empty.id,
        affirmation: json[Letter.fieldAffirmation]
            ? Affirmation.fromJson(json[Letter.fieldAffirmation])
            : empty.affirmation,
        reaffirmations: reaffirmations,
        createdOn:
            DateTime.tryParse(json[Letter.fieldCreatedOn]) ?? empty.createdOn,
        opened: json[Letter.fieldOpened] ?? empty.opened);
  }

  @override
  List<Object> get props =>
      [id, affirmation, reaffirmations, createdOn, opened];
}
