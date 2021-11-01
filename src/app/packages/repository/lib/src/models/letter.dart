import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/models/reaffirmation.dart';

class Letter extends Equatable {
  const Letter({
    required this.id,
    required this.affirmations,
    required this.totalAffirmations,
    required this.createdOn,
    this.opened = false,
    this.openedOn,
  });

  final String id;
  final List<LetterAffirmation> affirmations;
  final int totalAffirmations;
  final DateTime createdOn;
  final bool opened;
  final DateTime? openedOn;

  static final empty = Letter(
    id: '-',
    affirmations: [],
    totalAffirmations: 0,
    createdOn: DateTime.utc(0),
  );

  static const String fieldId = 'id';
  static const String fieldAffirmations = 'affirmations';
  static const String fieldTotalAffirmations = 'totalAffirmations';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldOpened = 'opened';
  static const String fieldOpenedOn = 'openedOn';

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldAffirmations: affirmations.map((e) => e.fieldValues).toList(),
        fieldTotalAffirmations: totalAffirmations,
        fieldCreatedOn: createdOn,
        fieldOpened: opened,
        fieldOpenedOn: openedOn,
      };

  static Letter fromJson(Map<String, dynamic> json) {
    return Letter(
      id: json[Letter.fieldId] ?? empty.id,
      affirmations: json[fieldAffirmations] != null
          ? (json[fieldAffirmations] as List<dynamic>)
              .map((e) => LetterAffirmation.fromJson(e))
              .toList()
          : empty.affirmations,
      totalAffirmations: json[fieldTotalAffirmations],
      createdOn:
          DateTime.tryParse(json[Letter.fieldCreatedOn]) ?? empty.createdOn,
      opened: json[Letter.fieldOpened] ?? empty.opened,
      openedOn: json[fieldOpenedOn] != null
          ? DateTime.parse(json[fieldOpenedOn])
          : null,
    );
  }

  Letter copyWith({
    String? id,
    List<LetterAffirmation>? affirmations,
    int? totalAffirmations,
    DateTime? createdOn,
    bool? opened,
    DateTime? openedOn,
  }) {
    return Letter(
      id: id ?? this.id,
      affirmations: affirmations ?? this.affirmations,
      totalAffirmations: totalAffirmations ?? this.totalAffirmations,
      createdOn: createdOn ?? this.createdOn,
      opened: opened ?? this.opened,
      openedOn: openedOn ?? this.openedOn,
    );
  }

  @override
  List<Object?> get props => [
        id,
        affirmations,
        totalAffirmations,
        createdOn,
        opened,
        openedOn,
      ];
}

class LetterAffirmation extends Equatable {
  const LetterAffirmation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.totalReaffirmations,
    required this.reaffirmations,
  });

  final String id;
  final String title;
  final String subtitle;
  final int totalReaffirmations;
  final List<LetterReaffirmation> reaffirmations;

  static const String fieldId = 'id';
  static const String fieldTitle = 'title';
  static const String fieldSubtitle = 'subtitle';
  static const String fieldTotalReaffirmations = 'totalReaffirmations';
  static const String fieldReaffirmations = 'reaffirmations';

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldTitle: title,
        fieldSubtitle: subtitle,
        fieldTotalReaffirmations: totalReaffirmations,
        fieldReaffirmations: reaffirmations.map((e) => e.fieldValues).toList(),
      };

  static LetterAffirmation empty = const LetterAffirmation(
    id: '-',
    title: '-',
    subtitle: '-',
    totalReaffirmations: 0,
    reaffirmations: [],
  );

  static LetterAffirmation fromJson(Map<String, dynamic> json) {
    return LetterAffirmation(
      id: json[fieldId],
      title: json[fieldTitle],
      subtitle: json[fieldSubtitle],
      totalReaffirmations: json[fieldTotalReaffirmations],
      reaffirmations: json[fieldReaffirmations] != null
          ? (json[fieldReaffirmations] as List<dynamic>)
              .map((e) => LetterReaffirmation.fromJson(e))
              .toList()
          : empty.reaffirmations,
    );
  }

  LetterAffirmation copyWith({
    String? id,
    String? title,
    String? subtitle,
    int? totalReaffirmations,
    List<LetterReaffirmation>? reaffirmations,
  }) {
    return LetterAffirmation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      totalReaffirmations: totalReaffirmations ?? this.totalReaffirmations,
      reaffirmations: reaffirmations ?? this.reaffirmations,
    );
  }

  @override
  List<Object> get props =>
      [id, title, subtitle, totalReaffirmations, reaffirmations];
}

class LetterReaffirmation extends Equatable {
  const LetterReaffirmation({
    required this.id,
    required this.createdOn,
    required this.font,
    required this.value,
    required this.stamp,
  });

  final String id;
  final DateTime createdOn;
  final ReaffirmationFont font;
  final ReaffirmationValue value;
  final ReaffirmationStamp stamp;

  static const String fieldId = 'id';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldFont = 'font';
  static const String fieldValue = 'value';
  static const String fieldStamp = 'stamp';

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldCreatedOn: createdOn.toIso8601String(),
        fieldFont: font.index,
        fieldValue: value.index,
        fieldStamp: stamp.index,
      };

  static LetterReaffirmation fromJson(Map<String, dynamic> json) {
    return LetterReaffirmation(
      id: json[fieldId],
      createdOn: DateTime.parse(json[fieldCreatedOn]),
      font: ReaffirmationFont.values[json[fieldFont]],
      value: ReaffirmationValue.values[json[fieldValue]],
      stamp: ReaffirmationStamp.values[json[fieldStamp]],
    );
  }

  LetterReaffirmation copyWith({
    String? id,
    DateTime? createdOn,
    ReaffirmationFont? font,
    ReaffirmationValue? value,
    ReaffirmationStamp? stamp,
  }) {
    return LetterReaffirmation(
      id: id ?? this.id,
      createdOn: createdOn ?? this.createdOn,
      font: font ?? this.font,
      value: value ?? this.value,
      stamp: stamp ?? this.stamp,
    );
  }

  @override
  List<Object> get props => [id, createdOn, font, value, stamp];
}
