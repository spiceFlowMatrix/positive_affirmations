import 'package:equatable/equatable.dart';

class Affirmation extends Equatable {
  const Affirmation({
    this.id = '',
    this.title = '',
    this.subtitle = '',
    this.likes = 0,
    this.totalReaffirmations = 0,
  });

  final String id;
  final String title;
  final String subtitle;
  final int likes;
  final int totalReaffirmations;

  @override
  List<Object> get props => [id, title, subtitle, likes, totalReaffirmations];

  static const empty = Affirmation(id: '-', title: '-', subtitle: '-');
  static const String fieldId = 'id';
  static const String fieldTitle = 'title';
  static const String fieldSubtitle = 'subtitle';
  static const String fieldLikes = 'likes';
  static const String fieldTotalReaffirmations = 'totalReaffirmations';

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldTitle: this.title,
        fieldSubtitle: this.subtitle,
        fieldLikes: this.likes,
        fieldTotalReaffirmations: this.totalReaffirmations,
      };

  static Affirmation fromJson(Map<String, dynamic> json) {
    return Affirmation(
      id: json[Affirmation.fieldId] ?? '',
      title: json[Affirmation.fieldTitle] ?? '',
      subtitle: json[Affirmation.fieldSubtitle] ?? '',
      likes: json[Affirmation.fieldLikes] ?? 0,
      totalReaffirmations: json[Affirmation.fieldTotalReaffirmations] ?? 0,
    );
  }

  Affirmation copyWith({
    String? id,
    String? title,
    String? subtitle,
    int? likes,
    int? totalReaffirmations,
  }) {
    return Affirmation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      likes: likes ?? this.likes,
      totalReaffirmations: totalReaffirmations ?? this.totalReaffirmations,
    );
  }
}
