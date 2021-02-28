import 'package:affirmations_repository_core/affirmations_repository_core.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Affirmation extends Equatable {
  final String id;
  final String title;
  final String message;

  Affirmation(
    this.title,
    this.message, {
    String id,
  }) : this.id = id ?? Uuid().v4();

  Affirmation copyWith({
    String id,
    String title,
    String message,
    DateTime remindOn,
  }) {
    return Affirmation(
      title ?? this.title,
      message ?? this.message,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id, title, message];

  @override
  String toString() {
    return 'Affirmation { id: $id, title: $title, message: $message}';
  }

  AffirmationEntity toEntity() {
    return AffirmationEntity(
      id: id,
      title: title,
      message: message,
    );
  }

  static Affirmation fromEntity(AffirmationEntity entity) {
    return Affirmation(
      entity.title,
      entity.message,
      id: entity.id,
    );
  }
}
