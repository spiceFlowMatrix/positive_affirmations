import 'package:equatable/equatable.dart';

enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }
enum ReaffirmationGraphic { empty, takeOff, medal, thumbsUp }

class Reaffirmation extends Equatable {
  Reaffirmation({
    required this.id,
    required this.affirmationId,
    required this.createdOn,
    required this.value,
    required this.graphic,
  });

  final int id;
  final int affirmationId;
  final DateTime createdOn;
  final ReaffirmationValue value;
  final ReaffirmationGraphic graphic;
  static const String fieldId = 'id';
  static const String fieldAffirmationId = 'affirmationId';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldValue = 'value';
  static const String fieldGraphic = 'graphic';

  static final empty = Reaffirmation(
    id: 0,
    affirmationId: 0,
    createdOn: DateTime(0),
    value: ReaffirmationValue.empty,
    graphic: ReaffirmationGraphic.empty,
  );

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldAffirmationId: this.affirmationId,
        fieldCreatedOn: this.createdOn.toIso8601String(),
        fieldValue: this.value.index,
        fieldGraphic: this.graphic.index,
      };

  static Reaffirmation fromJson(Map<String, dynamic> json) {
    return Reaffirmation(
      id: json[Reaffirmation.fieldId] ?? empty.id,
      affirmationId: json[Reaffirmation.fieldAffirmationId] ?? empty.id,
      createdOn: DateTime.tryParse(json[Reaffirmation.fieldCreatedOn]) ??
          empty.createdOn,
      value: json[Reaffirmation.fieldValue]
          ? ReaffirmationValue.values[json[Reaffirmation.fieldValue]]
          : empty.value,
      graphic: json[Reaffirmation.fieldGraphic]
          ? ReaffirmationGraphic.values[json[Reaffirmation.fieldGraphic]]
          : empty.graphic,
    );
  }

  Reaffirmation copyWith({
    int? id,
    int? affirmationId,
    DateTime? createdOn,
    ReaffirmationValue? value,
    ReaffirmationGraphic? graphic,
  }) {
    return new Reaffirmation(
      id: id ?? this.id,
      affirmationId: affirmationId ?? this.affirmationId,
      createdOn: createdOn ?? this.createdOn,
      value: value ?? this.value,
      graphic: graphic ?? this.graphic,
    );
  }

  @override
  List<Object> get props => [id, affirmationId, createdOn, value, graphic];
}
