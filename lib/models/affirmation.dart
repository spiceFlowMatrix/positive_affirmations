import 'package:affirmations_repository_core/affirmations_repository_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Affirmation extends Equatable {
  final String id;
  final String message;
  final DateTime remindOn;

  Affirmation(
    this.message,
    this.remindOn, {
    String id,
  }) : this.id = id ?? Uuid().v4();

  Affirmation copyWith({
    String id,
    String message,
    TimeOfDay remindOn,
  }) {
    return Affirmation(
      message ?? this.message,
      remindOn ?? this.remindOn,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id, message, remindOn];

  @override
  String toString() {
    return 'Affirmation { id: $id, message: $message, $remindOn: remindOn }';
  }

  AffirmationEntity toEntity() {
    return AffirmationEntity(
      id: id,
      message: message,
      remindOn: remindOn.toString(),
    );
  }

  static Affirmation fromEntity(AffirmationEntity entity) {
    return Affirmation(
      entity.message,
      DateTime.parse(entity.remindOn),
      id: entity.id,
    );
  }
}
