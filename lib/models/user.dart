import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  final String id;
  // The user's actual name
  final String name;
  // The name that the user wants the app to call them
  final String callingName;

  User(
    this.name,
    this.callingName, {
    String id,
  }) : this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [id, name, callingName];
}
