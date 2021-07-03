import 'package:equatable/equatable.dart';

class Affirmation extends Equatable {
  const Affirmation({
    required this.id,
    required this.title,
    this.subtitle = '-',
    required this.createdOn,
    this.likes = 0,
    this.totalReaffirmations = 0,
    this.active = true,
    this.liked = false,
  });

  final int id;
  final String title;
  final String subtitle;
  final DateTime createdOn;
  final int likes;
  final int totalReaffirmations;
  final bool liked;
  final bool active;

  @override
  List<Object> get props => [
        id,
        title,
        subtitle,
        createdOn,
        likes,
        totalReaffirmations,
        active,
        liked,
      ];

  static final empty =
      Affirmation(id: 0, title: '-', subtitle: '-', createdOn: DateTime.utc(0));
  static const String fieldId = 'id';
  static const String fieldTitle = 'title';
  static const String fieldSubtitle = 'subtitle';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldLikes = 'likes';
  static const String fieldTotalReaffirmations = 'totalReaffirmations';
  static const String fieldActive = 'active';
  static const String fieldLiked = 'liked';

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldTitle: this.title,
        fieldSubtitle: this.subtitle,
        fieldCreatedOn: this.createdOn.toIso8601String(),
        fieldLikes: this.likes,
        fieldTotalReaffirmations: this.totalReaffirmations,
        fieldActive: this.active,
        fieldLiked: this.liked,
      };

  static Affirmation fromJson(Map<String, dynamic> json) {
    return Affirmation(
      id: json[Affirmation.fieldId] ?? empty.id,
      title: json[Affirmation.fieldTitle] ?? empty.title,
      subtitle: json[Affirmation.fieldSubtitle] ?? empty.subtitle,
      createdOn: DateTime.tryParse('${json[Affirmation.fieldCreatedOn]}') ??
          empty.createdOn,
      likes: json[Affirmation.fieldLikes] ?? empty.likes,
      totalReaffirmations: json[Affirmation.fieldTotalReaffirmations] ??
          empty.totalReaffirmations,
      active: json[Affirmation.fieldActive] ?? empty.active,
      liked: json[Affirmation.fieldLiked] ?? empty.liked,
    );
  }

  Affirmation copyWith({
    int? id,
    String? title,
    String? subtitle,
    DateTime? createdOn,
    int? likes,
    int? totalReaffirmations,
    bool? active,
    bool? liked,
  }) {
    return Affirmation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      createdOn: createdOn ?? this.createdOn,
      likes: likes ?? this.likes,
      totalReaffirmations: totalReaffirmations ?? this.totalReaffirmations,
      active: active ?? this.active,
      liked: liked ?? this.liked,
    );
  }
}
