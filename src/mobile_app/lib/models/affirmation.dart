import 'package:equatable/equatable.dart';

class Affirmation extends Equatable {
  const Affirmation({
    this.id = '',
    this.title = '',
    this.subtitle = '',
    this.createdOn = '',
    this.modifiedOn = '',
    this.likes = 0,
    this.totalReaffirmations = 0,
    this.active = true,
  });

  final String id;
  final String title;
  final String subtitle;

  /// Value must be a Iso8601 String.
  /// Use the `toIso8601String()` on the DateTime class to ensure correct values are stored.
  final String createdOn;

  /// Value must be a Iso8601 String.
  /// Use the `toIso8601String()` on the DateTime class to ensure correct values are stored.
  final String modifiedOn;
  final int likes;
  final int totalReaffirmations;
  final bool active;

  @override
  List<Object> get props => [
        id,
        title,
        subtitle,
        createdOn,
        modifiedOn,
        likes,
        totalReaffirmations,
        active,
      ];

  static const empty = Affirmation(id: '-', title: '-', subtitle: '-');
  static const String fieldId = 'id';
  static const String fieldTitle = 'title';
  static const String fieldSubtitle = 'subtitle';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldModifiedOn = 'modifiedOn';
  static const String fieldLikes = 'likes';
  static const String fieldTotalReaffirmations = 'totalReaffirmations';
  static const String fieldActive = 'active';

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldTitle: this.title,
        fieldSubtitle: this.subtitle,
        fieldCreatedOn: this.createdOn,
        fieldModifiedOn: this.modifiedOn,
        fieldLikes: this.likes,
        fieldTotalReaffirmations: this.totalReaffirmations,
        fieldActive: this.active,
      };

  static Affirmation fromJson(Map<String, dynamic> json) {
    return Affirmation(
      id: json[Affirmation.fieldId] ?? '',
      title: json[Affirmation.fieldTitle] ?? '',
      subtitle: json[Affirmation.fieldSubtitle] ?? '',
      createdOn: json[Affirmation.fieldCreatedOn] ?? '',
      modifiedOn: json[Affirmation.fieldModifiedOn] ?? '',
      likes: json[Affirmation.fieldLikes] ?? 0,
      totalReaffirmations: json[Affirmation.fieldTotalReaffirmations] ?? 0,
      active: json[Affirmation.fieldActive] ?? true,
    );
  }

  Affirmation copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? createdOn,
    String? modifiedOn,
    int? likes,
    int? totalReaffirmations,
    bool? active,
  }) {
    return Affirmation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      createdOn: createdOn ?? this.createdOn,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      likes: likes ?? this.likes,
      totalReaffirmations: totalReaffirmations ?? this.totalReaffirmations,
      active: active ?? this.active,
    );
  }
}
