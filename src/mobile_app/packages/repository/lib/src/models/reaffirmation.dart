import 'package:equatable/equatable.dart';

enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }
enum ReaffirmationStamp { empty, takeOff, medal, thumbsUp }
enum ReaffirmationFont {
  none,
  birthstone,
  explora,
  bonheurRoyale,
  ephesis,
  roboto,
  gemunuLibre,
  montserrat
}

class Reaffirmation extends Equatable {
  const Reaffirmation({
    required this.id,
    required this.affirmationId,
    required this.createdOn,
    required this.value,
    required this.font,
    required this.stamp,
  });

  final int id;
  final int affirmationId;
  final DateTime createdOn;
  final ReaffirmationValue value;
  final ReaffirmationFont font;
  final ReaffirmationStamp stamp;
  static const String fieldId = 'id';
  static const String fieldAffirmationId = 'affirmationId';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldValue = 'value';
  static const String fieldFont = 'font';
  static const String fieldStamp = 'stamp';

  static final empty = Reaffirmation(
    id: 0,
    affirmationId: 0,
    createdOn: DateTime(0),
    value: ReaffirmationValue.empty,
    font: ReaffirmationFont.none,
    stamp: ReaffirmationStamp.empty,
  );

  Map<String, dynamic> get fieldValues =>
      {
        fieldId: this.id,
        fieldAffirmationId: this.affirmationId,
        fieldCreatedOn: this.createdOn.toIso8601String(),
        fieldValue: this.value.index,
        fieldFont: this.font.index,
        fieldStamp: this.stamp.index,
      };

  static Reaffirmation fromJson(Map<String, dynamic> json) {
    return Reaffirmation(
      id: json[Reaffirmation.fieldId] ?? empty.id,
      affirmationId: json[Reaffirmation.fieldAffirmationId] ?? empty.id,
      createdOn: DateTime.tryParse('${json[Reaffirmation.fieldCreatedOn]}') ??
          empty.createdOn,
      value: json[Reaffirmation.fieldValue] != null
          ? ReaffirmationValue.values[json[Reaffirmation.fieldValue]]
          : empty.value,
      font: json[Reaffirmation.fieldFont] != null
          ? ReaffirmationFont.values[json[Reaffirmation.fieldFont]]
          : empty.font,
      stamp: json[Reaffirmation.fieldStamp] != null
          ? ReaffirmationStamp.values[json[Reaffirmation.fieldStamp]]
          : empty.stamp,
    );
  }

  Reaffirmation copyWith({
    int? id,
    int? affirmationId,
    DateTime? createdOn,
    ReaffirmationValue? value,
    ReaffirmationFont? font,
    ReaffirmationStamp? stamp,
  }) {
    return new Reaffirmation(
      id: id ?? this.id,
      affirmationId: affirmationId ?? this.affirmationId,
      createdOn: createdOn ?? this.createdOn,
      value: value ?? this.value,
      font: font ?? this.font,
      stamp: stamp ?? this.stamp,
    );
  }

  @override
  List<Object> get props => [id, affirmationId, createdOn, value, font, stamp];
}
