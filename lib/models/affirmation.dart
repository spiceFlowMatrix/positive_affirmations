import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Affirmation extends Equatable {
  final String id;
  final String message;
  final TimeOfDay remindOn;

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
  // TODO: implement props
  List<Object> get props => [
        id,
        message,
        remindOn,
      ];
}
