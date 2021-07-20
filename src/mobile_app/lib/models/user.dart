import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    this.nickName = '',
    this.email = '',
    this.pictureB64Enc = '',
    this.accountCreated = false,
    this.emailVerified = false,
  });

  final String id;
  final String name;
  final String nickName;
  final String pictureB64Enc;
  final String email;
  final bool accountCreated;
  final bool emailVerified;

  @override
  List<Object?> get props => [
        id,
        name,
        nickName,
        email,
        pictureB64Enc,
        accountCreated,
        emailVerified,
      ];

  static const empty = User(
    id: '-',
    name: '-',
    nickName: '-',
    email: '-',
    pictureB64Enc: '-',
  );
  static const String fieldId = 'id';
  static const String fieldName = 'name';
  static const String fieldNickName = 'nickName';
  static const String fieldEmail = 'email';
  static const String fieldPictureB64Enc = 'pictureB64Enc';
  static const String fieldAccountCreated = 'accountCreated';
  static const String fieldEmailVerified = 'emailVerified';

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldName: this.name,
        fieldNickName: this.nickName,
        fieldEmail: this.email,
        fieldPictureB64Enc: this.pictureB64Enc,
        fieldAccountCreated: this.accountCreated,
        fieldEmailVerified: this.emailVerified,
      };

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json[User.fieldId],
      name: json[User.fieldName],
      nickName: json[User.fieldNickName] ?? '',
      email: json[User.fieldEmail] ?? '',
      pictureB64Enc: json[User.fieldPictureB64Enc] ?? '',
      accountCreated: json[User.fieldAccountCreated] ?? false,
      emailVerified: json[User.fieldEmailVerified] ?? false,
    );
  }
}
