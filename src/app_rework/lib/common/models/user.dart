import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:positive_affirmations/common/models/affirmation_like.dart';
import 'package:repository/src/models/models.dart';

enum LetterCreationSchedule { daily, weekly, monthly, never }

class AppUser extends Equatable {
  const AppUser({
    required this.dbId,
    required this.dbUiId,
    required this.uid,
    this.displayName,
    this.email,
    required this.emailVerified,
    this.nickName,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
    this.affirmationLikes = const [],
    this.affirmations = const [],
    this.letterSchedule = LetterCreationSchedule.never,
    this.letters = const [],
    DateTime? lettersLastGeneratedOn,
    this.reaffirmations = const [],
  }) : _lettersLastGeneratedOn = lettersLastGeneratedOn;

  AppUser.fromDto(UserDto dto)
      : dbId = dto.dbId!.toInt(),
        dbUiId = dto.dbUiId!,
        uid = dto.uid!,
        displayName = dto.displayName,
        email = dto.email,
        emailVerified = dto.emailVerified!,
        nickName = dto.nickName,
        phoneNumber = dto.phoneNumber,
        photoURL = dto.photoURL,
        providerId = dto.providerId,
        _lettersLastGeneratedOn = dto.lettersLastGeneratedOn;

  final int dbId;
  final String dbUiId;
  final String uid;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final String? nickName;
  final String? phoneNumber;
  final String? photoURL;
  final String? providerId;
  final List<AffirmationLike> affirmationLikes;
  final List<Affirmation> affirmations;
  final LetterCreationSchedule letterSchedule;
  final List<Letter> letters;
  final DateTime? _lettersLastGeneratedOn;
  final List<Reaffirmation> reaffirmations;

  DateTime get lettersLastGeneratedOn => _lettersLastGeneratedOn ?? DateTime(0);

  // Reference for working solution https://stackoverflow.com/a/61289387
  String? nameInitials() {
    if (displayName == null) return null;
    List<String> names = displayName!.split(' ');
    String initials = '';
    int numWords = 2;

    if (numWords >= names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }

  // Reference for working solution https://stackoverflow.com/a/61289387
  String? nickNameInitials() {
    if (nickName == null) return null;
    List<String> names = nickName!.split(' ');
    String initials = '';
    int numWords = 2;

    if (numWords >= names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }

  AppUser copyWith({
    int? dbId,
    String? dbUiId,
    String? uid,
    String? displayName,
    String? email,
    bool? emailVerified,
    String? nickName,
    String? phoneNumber,
    String? photoURL,
    String? providerId,
    List<AffirmationLike>? affirmationLikes,
    List<Affirmation>? affirmations,
    LetterCreationSchedule? letterSchedule,
    List<Letter>? letters,
    DateTime? lettersLastGeneratedOn,
    List<Reaffirmation>? reaffirmations,
  }) {
    return AppUser(
      dbId: dbId ?? this.dbId,
      dbUiId: dbUiId ?? this.dbUiId,
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      nickName: nickName ?? this.nickName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      providerId: providerId ?? this.providerId,
      affirmationLikes: affirmationLikes ?? this.affirmationLikes,
      affirmations: affirmations ?? this.affirmations,
      letterSchedule: letterSchedule ?? this.letterSchedule,
      letters: letters ?? this.letters,
      lettersLastGeneratedOn:
          lettersLastGeneratedOn ?? this.lettersLastGeneratedOn,
      reaffirmations: reaffirmations ?? this.reaffirmations,
    );
  }

  @override
  List<Object?> get props => [
        dbId,
        dbUiId,
        uid,
        displayName,
        email,
        emailVerified,
        nickName,
        phoneNumber,
        photoURL,
        providerId,
        affirmationLikes,
        affirmations,
        letterSchedule,
        letters,
        _lettersLastGeneratedOn,
        lettersLastGeneratedOn,
        reaffirmations,
      ];

  static const empty = AppUser(
    dbId: 0,
    dbUiId: 'empty',
    uid: 'empty',
    emailVerified: false,
  );
}
