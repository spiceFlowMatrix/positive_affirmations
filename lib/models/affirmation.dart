import 'package:affirmations_repository_core/affirmations_repository_core.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Affirmation extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime remindOn;

  Affirmation(
    this.title,
    this.message,
    this.remindOn, {
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
      remindOn ?? this.remindOn,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id, title, message, remindOn];

  @override
  String toString() {
    return 'Affirmation { id: $id, title: $title, message: $message, $remindOn: remindOn }';
  }

  AffirmationEntity toEntity() {
    return AffirmationEntity(
      id: id,
      title: title,
      message: message,
      remindOn: remindOn.toString(),
    );
  }

  static Affirmation fromEntity(AffirmationEntity entity) {
    return Affirmation(
      entity.title,
      entity.message,
      DateTime.parse(entity.remindOn),
      id: entity.id,
    );
  }
}
