// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:positive_affirmations/common/models/models.dart';

class Affirmation extends Equatable {
  const Affirmation({
    required this.id,
    required this.uiId,
    required this.title,
    this.subtitle,
    required this.active,
    required this.createdBy,
    DateTime? createdOn,
    this.likes = const [],
    this.reaffirmations = const [],
  }) : _createdOn = createdOn;

  Affirmation.fromDto(AffirmationDto dto)
      : id = dto.id!.toInt(),
        uiId = dto.uiId!,
        title = dto.title!,
        subtitle = dto.subtitle,
        active = dto.active!,
        createdBy = AppUser.fromDto(dto.createdBy!),
        _createdOn = dto.createdOn,
        likes = dto.likes == null
            ? const []
            : dto.likes!
                .map((e) => AffirmationLike(
                      id: e.id!.toInt(),
                      uiId: e.uiId!,
                      byUser: AppUser.fromDto(e.byUser!),
                    ))
                .toList();

  final int id;
  final String uiId;
  final String title;
  final String? subtitle;
  final bool active;
  final AppUser createdBy;
  final DateTime? _createdOn;
  final List<AffirmationLike> likes;
  final List<Reaffirmation> reaffirmations;

  DateTime get createdOn => _createdOn ?? DateTime(0);

  static const Affirmation empty = Affirmation(
    id: 0,
    uiId: 'empty',
    title: 'empty',
    active: false,
    createdBy: AppUser.empty,
  );

  Affirmation copyWith({
    int? id,
    String? uiId,
    String? title,
    String? subtitle,
    bool? active,
    AppUser? createdBy,
    DateTime? createdOn,
    List<AffirmationLike>? likes,
    List<Reaffirmation>? reaffirmations,
  }) {
    return Affirmation(
      id: id ?? this.id,
      uiId: uiId ?? this.uiId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      active: active ?? this.active,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? _createdOn,
      likes: likes ?? this.likes,
      reaffirmations: reaffirmations ?? this.reaffirmations,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uiId,
        title,
        subtitle,
        active,
        createdBy,
        createdOn,
        _createdOn,
        likes,
        reaffirmations
      ];
}
