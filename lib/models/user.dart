import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  final String id;
  // The user's actual name
  final String name;
  // The name that the user wants the app to call them
  final String callingName;
  final String description;

  User(
    this.name,
    this.callingName, {
    String id,
    this.description,
  }) : this.id = id ?? Uuid().v4();

  User copyWith({
    String id,
    String name,
    String callingName,
    String description,
  }) {
    return User(
      name ?? this.name,
      callingName ?? this.callingName,
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [id, name, callingName, description];
}
