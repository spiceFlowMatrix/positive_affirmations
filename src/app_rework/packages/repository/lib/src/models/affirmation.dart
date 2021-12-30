// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/src/models/models.dart';

class Affirmation extends Equatable {
  const Affirmation({
    required this.id,
    required this.title,
    this.subtitle = '',
    DateTime? createdOn,
    required this.createdById,
    this.likeCount = 0,
    this.totalReaffirmations = 0,
    this.active = true,
    this.likes = const [],
    this.liked = false,
  }) : _createdOn = createdOn;

  final String id;
  final String title;
  final String subtitle;
  final String createdById;
  final DateTime? _createdOn;
  final int likeCount;
  final int totalReaffirmations;
  final List<AffirmationLike> likes;
  final bool liked;
  final bool active;

  static const Affirmation empty = Affirmation(
    id: '-',
    title: '-',
    subtitle: '-',
    createdById: '-',
  );
  static const String fieldId = 'id';
  static const String fieldTitle = 'title';
  static const String fieldSubtitle = 'subtitle';
  static const String fieldCreatedById = 'createdById';
  static const String fieldCreatedOn = 'createdOn';
  static const String fieldLikeCount = 'likeCount';
  static const String fieldTotalReaffirmations = 'totalReaffirmations';
  static const String fieldActive = 'active';
  static const String fieldLikes = 'likes';
  static const String fieldLiked = 'liked';

  Affirmation copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? createdById,
    DateTime? createdOn,
    int? likeCount,
    int? totalReaffirmations,
    bool? active,
    bool? liked,
    List<AffirmationLike>? likes,
  }) {
    return Affirmation(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      createdById: createdById ?? this.createdById,
      createdOn: createdOn ?? _createdOn,
      likeCount: likeCount ?? this.likeCount,
      totalReaffirmations: totalReaffirmations ?? this.totalReaffirmations,
      active: active ?? this.active,
      liked: liked ?? this.liked,
      likes: likes ?? this.likes,
    );
  }

  DateTime get createdOn => _createdOn ?? DateTime(0);

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldTitle: title,
        fieldSubtitle: subtitle,
        fieldCreatedById: createdById,
        fieldCreatedOn: createdOn.toIso8601String(),
        fieldLikeCount: likeCount,
        fieldTotalReaffirmations: totalReaffirmations,
        fieldActive: active,
        fieldLikes: likes.map((e) => e.fieldValues).toList(),
      };

  static Affirmation fromJson(Map<String, dynamic> json) {
    return Affirmation(
      id: json[Affirmation.fieldId] ?? empty.id,
      title: json[Affirmation.fieldTitle] ?? empty.title,
      subtitle: json[Affirmation.fieldSubtitle] ?? empty.subtitle,
      createdById: json[Affirmation.fieldCreatedById] ?? empty.createdById,
      createdOn: DateTime.tryParse('${json[Affirmation.fieldCreatedOn]}') ??
          empty.createdOn,
      likeCount: json[Affirmation.fieldLikeCount] ?? empty.likeCount,
      likes: json[Affirmation.fieldLikes] != null
          ? (json[Affirmation.fieldLikes] as List<dynamic>)
              .map((e) => AffirmationLike.fromJson(e))
              .toList()
          : empty.likes,
      totalReaffirmations: json[Affirmation.fieldTotalReaffirmations] ??
          empty.totalReaffirmations,
      active: json[Affirmation.fieldActive] ?? empty.active,
    );
  }

  // static Affirmation fromSnapshot(DocumentSnapshot snap) {
  //   return Affirmation(
  //     id: snap.get(fieldId),
  //     title: snap.get(fieldTitle),
  //     subtitle: snap.get(fieldSubtitle),
  //     createdById: snap.get(fieldCreatedById),
  //     createdOn: DateTime.parse(snap.get(fieldCreatedOn)),
  //     likeCount: snap.get(fieldLikeCount),
  //     totalReaffirmations: snap.get(fieldTotalReaffirmations),
  //     active: snap.get(fieldActive),
  //     likes: (snap.data() as Affirmation).likes,
  //     // liked: snap.get(fieldLiked),
  //   );
  // }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        createdOn,
        _createdOn,
        createdById,
        likeCount,
        likes,
        totalReaffirmations,
        active,
        liked,
      ];
}
