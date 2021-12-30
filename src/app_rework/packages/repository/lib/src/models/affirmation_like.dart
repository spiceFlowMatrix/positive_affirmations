import 'package:equatable/equatable.dart';

class AffirmationLike extends Equatable {
  const AffirmationLike({
    required this.id,
    required this.byUserId,
  });

  final String id;
  final String byUserId;

  static const String fieldId = 'id';
  static const String fieldByUserId = 'byUserId';

  static const AffirmationLike empty = AffirmationLike(
    id: '-',
    byUserId: '-',
  );

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldByUserId: byUserId,
      };

  static AffirmationLike fromJson(Map<String, dynamic> json) {
    return AffirmationLike(
      id: json[AffirmationLike.fieldId] ?? empty.id,
      byUserId: json[AffirmationLike.fieldByUserId] ?? empty.byUserId,
    );
  }

  @override
  List<Object> get props => [id, byUserId];
}
