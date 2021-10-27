import 'package:equatable/equatable.dart';

enum LetterCreationSchedule { daily, monthly, never }

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.name,
    this.nickName = '',
    this.email = '',
    this.pictureUrl = '',
    this.emailVerified = false,
  });

  final String id;
  final String name;
  final String nickName;
  final String pictureUrl;
  final String email;
  final bool emailVerified;

  // Reference for working solution https://stackoverflow.com/a/61289387
  String nameInitials() {
    List<String> names = name.split(' ');
    String initials = '';
    int numWords = 2;

    if (numWords >= names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  // Reference for working solution https://stackoverflow.com/a/61289387
  String nickNameInitials() {
    List<String> names = nickName.split(' ');
    String initials = '';
    int numWords = 2;

    if (numWords >= names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  AppUser copyWith({
    String? id,
    String? name,
    String? nickName,
    String? pictureB64Enc,
    String? email,
    bool? emailVerified,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      pictureUrl: pictureB64Enc ?? this.pictureUrl,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        nickName,
        email,
        pictureUrl,
        emailVerified,
      ];

  static const empty = AppUser(
    id: '-',
    name: 'name',
    nickName: 'nickName',
    email: '-',
    pictureUrl: '-',
  );
  static const String fieldId = 'id';
  static const String fieldName = 'name';
  static const String fieldNickName = 'nickName';
  static const String fieldEmail = 'email';
  static const String fieldPictureUrl = 'pictureUrl';
  static const String fieldEmailVerified = 'emailVerified';

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldName: name,
        fieldNickName: nickName,
        fieldEmail: email,
        fieldPictureUrl: pictureUrl,
        fieldEmailVerified: emailVerified,
      };

  static AppUser fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json[AppUser.fieldId],
      name: json[AppUser.fieldName],
      nickName: json[AppUser.fieldNickName] ?? '',
      email: json[AppUser.fieldEmail] ?? '',
      pictureUrl: json[AppUser.fieldPictureUrl] ?? '',
      emailVerified: json[AppUser.fieldEmailVerified] ?? false,
    );
  }
}
