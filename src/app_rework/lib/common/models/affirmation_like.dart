import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:positive_affirmations/common/models/models.dart';

class AffirmationLike extends Equatable {
  const AffirmationLike({
    required this.id,
    required this.uiId,
    required this.byUser,
    DateTime? createdOn,
  }) : _createdOn = createdOn;

  AffirmationLike.fromDto(AffirmationLikeDto dto)
      : id = dto.id!.toInt(),
        uiId = dto.uiId!,
        byUser = AppUser.fromDto(dto.byUser!),
        _createdOn = dto.createdOn;

  final int id;
  final String uiId;
  final AppUser byUser;
  final DateTime? _createdOn;

  DateTime get createdOn => _createdOn ?? DateTime(0);

  static const AffirmationLike empty = AffirmationLike(
    id: 0,
    byUser: AppUser.empty,
    uiId: 'empty',
  );

  @override
  List<Object?> get props => [
        id,
        uiId,
        byUser,
        _createdOn,
        createdOn,
      ];
}
