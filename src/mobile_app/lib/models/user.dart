import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    this.nickName = '',
    this.email = '',
    this.accountCreated = false,
    this.emailVerified = false,
  });

  final String id;
  final String name;
  final String nickName;
  final String email;
  final bool accountCreated;
  final bool emailVerified;

  @override
  List<Object?> get props =>
      [id, name, nickName, email, accountCreated, emailVerified];

  static const empty = User(id: '-', name: '-', nickName: '-', email: '-');
  static const String fieldId = 'id';
  static const String fieldName = 'name';
  static const String fieldNickName = 'nickName';
  static const String fieldEmail = 'email';
  static const String fieldAccountCreated = 'accountCreated';
  static const String fieldEmailVerified = 'emailVerified';

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldName: this.name,
        fieldNickName: this.nickName,
        fieldEmail: this.email,
        fieldAccountCreated: this.accountCreated,
        fieldEmailVerified: this.emailVerified,
      };

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json[User.fieldId],
      name: json[User.fieldName],
      nickName: json[User.fieldNickName] ?? '',
      email: json[User.fieldEmail] ?? '',
      accountCreated: json[User.fieldAccountCreated] ?? false,
      emailVerified: json[User.fieldEmailVerified] ?? false,
    );
  }
}
