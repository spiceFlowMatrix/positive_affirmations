import 'package:equatable/equatable.dart';

enum LetterCreationSchedule { daily, weekly, monthly, never }

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.name,
    this.nickName = '',
    this.email = '',
    this.pictureUrl = '',
    this.emailVerified = false,
    this.letterSchedule = LetterCreationSchedule.never,
    this.lettersLastGeneratedOn,
    this.letterCount = 0,
    this.reaffirmationCount = 0,
    this.affirmationCount = 0,
  });

  final String id;
  final String name;
  final String nickName;
  final String pictureUrl;
  final String email;
  final bool emailVerified;
  final LetterCreationSchedule letterSchedule;
  final DateTime? lettersLastGeneratedOn;
  final int letterCount;
  final int reaffirmationCount;
  final int affirmationCount;

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
    String? pictureUrl,
    String? email,
    bool? emailVerified,
    LetterCreationSchedule? letterSchedule,
    DateTime? lettersLastGeneratedOn,
    int? letterCount,
    int? reaffirmationCount,
    int? affirmationCount,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      letterSchedule: letterSchedule ?? this.letterSchedule,
      lettersLastGeneratedOn:
          lettersLastGeneratedOn ?? this.lettersLastGeneratedOn,
      letterCount: letterCount ?? this.letterCount,
      reaffirmationCount: reaffirmationCount ?? this.reaffirmationCount,
      affirmationCount: affirmationCount ?? this.affirmationCount,
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
        letterSchedule,
        lettersLastGeneratedOn,
        letterCount,
        reaffirmationCount,
        affirmationCount,
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
  static const String fieldLetterSchedule = 'letterSchedule';
  static const String fieldLettersLastGeneratedOn = 'lettersLastGeneratedOn';
  static const String fieldLettersCount = 'lettersCount';
  static const String fieldReaffirmationCount = 'reaffirmationCount';
  static const String fieldAffirmationCount = 'affirmationCount';

  Map<String, dynamic> get fieldValues => {
        fieldId: id,
        fieldName: name,
        fieldNickName: nickName,
        fieldEmail: email,
        fieldPictureUrl: pictureUrl,
        fieldEmailVerified: emailVerified,
        fieldLetterSchedule: letterSchedule.index,
        fieldLettersLastGeneratedOn: lettersLastGeneratedOn,
        fieldLettersCount: letterCount,
        fieldReaffirmationCount: reaffirmationCount,
        fieldAffirmationCount: affirmationCount,
      };

  static AppUser fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json[AppUser.fieldId],
      name: json[AppUser.fieldName],
      nickName: json[AppUser.fieldNickName] ?? '',
      email: json[AppUser.fieldEmail] ?? '',
      pictureUrl: json[AppUser.fieldPictureUrl] ?? '',
      emailVerified: json[AppUser.fieldEmailVerified] ?? false,
      letterSchedule: json[AppUser.fieldLetterSchedule]
          ? LetterCreationSchedule.values[json[AppUser.fieldLetterSchedule]]
          : LetterCreationSchedule.never,
      lettersLastGeneratedOn: json[AppUser.fieldLettersLastGeneratedOn]
          ? DateTime.parse(json[AppUser.fieldLettersLastGeneratedOn])
          : null,
      letterCount: json[AppUser.fieldLettersCount],
      reaffirmationCount: json[AppUser.fieldReaffirmationCount],
      affirmationCount: json[AppUser.fieldAffirmationCount],
    );
  }
}
