import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    this.nickName,
  });

  final String id;
  final String name;
  final String? nickName;

  @override
  List<Object?> get props => [id, name, nickName];

  static const empty = User(id: '-', name: '-');
}
