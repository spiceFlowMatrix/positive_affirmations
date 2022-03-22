import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'api_client.enums.swagger.dart' as enums;

part 'api_client.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class AffirmationLikeDto {
  AffirmationLikeDto({
    this.id,
    this.uiId,
    this.byUser,
    this.createdOn,
  });

  factory AffirmationLikeDto.fromJson(Map<String, dynamic> json) =>
      _$AffirmationLikeDtoFromJson(json);

  @JsonKey(name: 'id')
  final double? id;
  @JsonKey(name: 'uiId')
  final String? uiId;
  @JsonKey(name: 'byUser')
  final UserDto? byUser;
  @JsonKey(name: 'createdOn')
  final DateTime? createdOn;
  static const fromJsonFactory = _$AffirmationLikeDtoFromJson;
  static const toJsonFactory = _$AffirmationLikeDtoToJson;
  Map<String, dynamic> toJson() => _$AffirmationLikeDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AffirmationLikeDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uiId, uiId) ||
                const DeepCollectionEquality().equals(other.uiId, uiId)) &&
            (identical(other.byUser, byUser) ||
                const DeepCollectionEquality().equals(other.byUser, byUser)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality()
                    .equals(other.createdOn, createdOn)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uiId) ^
      const DeepCollectionEquality().hash(byUser) ^
      const DeepCollectionEquality().hash(createdOn) ^
      runtimeType.hashCode;
}

extension $AffirmationLikeDtoExtension on AffirmationLikeDto {
  AffirmationLikeDto copyWith(
      {double? id, String? uiId, UserDto? byUser, DateTime? createdOn}) {
    return AffirmationLikeDto(
        id: id ?? this.id,
        uiId: uiId ?? this.uiId,
        byUser: byUser ?? this.byUser,
        createdOn: createdOn ?? this.createdOn);
  }
}

@JsonSerializable(explicitToJson: true)
class ReaffirmationDto {
  ReaffirmationDto({
    this.id,
    this.uiId,
    this.font,
    this.stamp,
    this.value,
    this.createdBy,
    this.createdOn,
    this.forAffirmation,
    this.inLetters,
  });

  factory ReaffirmationDto.fromJson(Map<String, dynamic> json) =>
      _$ReaffirmationDtoFromJson(json);

  @JsonKey(name: 'id')
  final double? id;
  @JsonKey(name: 'uiId')
  final String? uiId;
  @JsonKey(
      name: 'font',
      toJson: reaffirmationDtoFontToJson,
      fromJson: reaffirmationDtoFontFromJson)
  final enums.ReaffirmationDtoFont? font;
  @JsonKey(
      name: 'stamp',
      toJson: reaffirmationDtoStampToJson,
      fromJson: reaffirmationDtoStampFromJson)
  final enums.ReaffirmationDtoStamp? stamp;
  @JsonKey(
      name: 'value',
      toJson: reaffirmationDtoValueToJson,
      fromJson: reaffirmationDtoValueFromJson)
  final enums.ReaffirmationDtoValue? value;
  @JsonKey(name: 'createdBy')
  final UserDto? createdBy;
  @JsonKey(name: 'createdOn')
  final DateTime? createdOn;
  @JsonKey(name: 'forAffirmation')
  final AffirmationDto? forAffirmation;
  @JsonKey(name: 'inLetters', defaultValue: <LetterDto>[])
  final List<LetterDto>? inLetters;
  static const fromJsonFactory = _$ReaffirmationDtoFromJson;
  static const toJsonFactory = _$ReaffirmationDtoToJson;
  Map<String, dynamic> toJson() => _$ReaffirmationDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ReaffirmationDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uiId, uiId) ||
                const DeepCollectionEquality().equals(other.uiId, uiId)) &&
            (identical(other.font, font) ||
                const DeepCollectionEquality().equals(other.font, font)) &&
            (identical(other.stamp, stamp) ||
                const DeepCollectionEquality().equals(other.stamp, stamp)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality()
                    .equals(other.createdOn, createdOn)) &&
            (identical(other.forAffirmation, forAffirmation) ||
                const DeepCollectionEquality()
                    .equals(other.forAffirmation, forAffirmation)) &&
            (identical(other.inLetters, inLetters) ||
                const DeepCollectionEquality()
                    .equals(other.inLetters, inLetters)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uiId) ^
      const DeepCollectionEquality().hash(font) ^
      const DeepCollectionEquality().hash(stamp) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(createdOn) ^
      const DeepCollectionEquality().hash(forAffirmation) ^
      const DeepCollectionEquality().hash(inLetters) ^
      runtimeType.hashCode;
}

extension $ReaffirmationDtoExtension on ReaffirmationDto {
  ReaffirmationDto copyWith(
      {double? id,
      String? uiId,
      enums.ReaffirmationDtoFont? font,
      enums.ReaffirmationDtoStamp? stamp,
      enums.ReaffirmationDtoValue? value,
      UserDto? createdBy,
      DateTime? createdOn,
      AffirmationDto? forAffirmation,
      List<LetterDto>? inLetters}) {
    return ReaffirmationDto(
        id: id ?? this.id,
        uiId: uiId ?? this.uiId,
        font: font ?? this.font,
        stamp: stamp ?? this.stamp,
        value: value ?? this.value,
        createdBy: createdBy ?? this.createdBy,
        createdOn: createdOn ?? this.createdOn,
        forAffirmation: forAffirmation ?? this.forAffirmation,
        inLetters: inLetters ?? this.inLetters);
  }
}

@JsonSerializable(explicitToJson: true)
class LetterDto {
  LetterDto({
    this.id,
    this.uiId,
    this.createdBy,
    this.createdOn,
    this.opened,
    this.openedOn,
    this.reaffirmations,
  });

  factory LetterDto.fromJson(Map<String, dynamic> json) =>
      _$LetterDtoFromJson(json);

  @JsonKey(name: 'id')
  final double? id;
  @JsonKey(name: 'uiId')
  final String? uiId;
  @JsonKey(name: 'createdBy')
  final UserDto? createdBy;
  @JsonKey(name: 'createdOn')
  final DateTime? createdOn;
  @JsonKey(name: 'opened')
  final bool? opened;
  @JsonKey(name: 'openedOn')
  final DateTime? openedOn;
  @JsonKey(name: 'reaffirmations', defaultValue: <ReaffirmationDto>[])
  final List<ReaffirmationDto>? reaffirmations;
  static const fromJsonFactory = _$LetterDtoFromJson;
  static const toJsonFactory = _$LetterDtoToJson;
  Map<String, dynamic> toJson() => _$LetterDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LetterDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uiId, uiId) ||
                const DeepCollectionEquality().equals(other.uiId, uiId)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality()
                    .equals(other.createdOn, createdOn)) &&
            (identical(other.opened, opened) ||
                const DeepCollectionEquality().equals(other.opened, opened)) &&
            (identical(other.openedOn, openedOn) ||
                const DeepCollectionEquality()
                    .equals(other.openedOn, openedOn)) &&
            (identical(other.reaffirmations, reaffirmations) ||
                const DeepCollectionEquality()
                    .equals(other.reaffirmations, reaffirmations)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uiId) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(createdOn) ^
      const DeepCollectionEquality().hash(opened) ^
      const DeepCollectionEquality().hash(openedOn) ^
      const DeepCollectionEquality().hash(reaffirmations) ^
      runtimeType.hashCode;
}

extension $LetterDtoExtension on LetterDto {
  LetterDto copyWith(
      {double? id,
      String? uiId,
      UserDto? createdBy,
      DateTime? createdOn,
      bool? opened,
      DateTime? openedOn,
      List<ReaffirmationDto>? reaffirmations}) {
    return LetterDto(
        id: id ?? this.id,
        uiId: uiId ?? this.uiId,
        createdBy: createdBy ?? this.createdBy,
        createdOn: createdOn ?? this.createdOn,
        opened: opened ?? this.opened,
        openedOn: openedOn ?? this.openedOn,
        reaffirmations: reaffirmations ?? this.reaffirmations);
  }
}

@JsonSerializable(explicitToJson: true)
class UserDto {
  UserDto({
    this.dbId,
    this.dbUiId,
    this.uid,
    this.displayName,
    this.email,
    this.emailVerified,
    this.nickName,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
    this.affirmationLikes,
    this.affirmations,
    this.letterSchedule,
    this.letters,
    this.lettersLastGeneratedOn,
    this.reaffirmations,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  @JsonKey(name: 'dbId')
  final double? dbId;
  @JsonKey(name: 'dbUiId')
  final String? dbUiId;
  @JsonKey(name: 'uid')
  final String? uid;
  @JsonKey(name: 'displayName')
  final String? displayName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'emailVerified')
  final bool? emailVerified;
  @JsonKey(name: 'nickName')
  final String? nickName;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'photoURL')
  final String? photoURL;
  @JsonKey(name: 'providerId')
  final String? providerId;
  @JsonKey(name: 'affirmationLikes', defaultValue: <AffirmationLikeDto>[])
  final List<AffirmationLikeDto>? affirmationLikes;
  @JsonKey(name: 'affirmations', defaultValue: <AffirmationDto>[])
  final List<AffirmationDto>? affirmations;
  @JsonKey(
      name: 'letterSchedule',
      toJson: userDtoLetterScheduleToJson,
      fromJson: userDtoLetterScheduleFromJson)
  final enums.UserDtoLetterSchedule? letterSchedule;
  @JsonKey(name: 'letters', defaultValue: <LetterDto>[])
  final List<LetterDto>? letters;
  @JsonKey(name: 'lettersLastGeneratedOn')
  final DateTime? lettersLastGeneratedOn;
  @JsonKey(name: 'reaffirmations', defaultValue: <ReaffirmationDto>[])
  final List<ReaffirmationDto>? reaffirmations;
  static const fromJsonFactory = _$UserDtoFromJson;
  static const toJsonFactory = _$UserDtoToJson;
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDto &&
            (identical(other.dbId, dbId) ||
                const DeepCollectionEquality().equals(other.dbId, dbId)) &&
            (identical(other.dbUiId, dbUiId) ||
                const DeepCollectionEquality().equals(other.dbUiId, dbUiId)) &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.emailVerified, emailVerified) ||
                const DeepCollectionEquality()
                    .equals(other.emailVerified, emailVerified)) &&
            (identical(other.nickName, nickName) ||
                const DeepCollectionEquality()
                    .equals(other.nickName, nickName)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.photoURL, photoURL) ||
                const DeepCollectionEquality()
                    .equals(other.photoURL, photoURL)) &&
            (identical(other.providerId, providerId) ||
                const DeepCollectionEquality()
                    .equals(other.providerId, providerId)) &&
            (identical(other.affirmationLikes, affirmationLikes) ||
                const DeepCollectionEquality()
                    .equals(other.affirmationLikes, affirmationLikes)) &&
            (identical(other.affirmations, affirmations) ||
                const DeepCollectionEquality()
                    .equals(other.affirmations, affirmations)) &&
            (identical(other.letterSchedule, letterSchedule) ||
                const DeepCollectionEquality()
                    .equals(other.letterSchedule, letterSchedule)) &&
            (identical(other.letters, letters) ||
                const DeepCollectionEquality()
                    .equals(other.letters, letters)) &&
            (identical(other.lettersLastGeneratedOn, lettersLastGeneratedOn) ||
                const DeepCollectionEquality().equals(
                    other.lettersLastGeneratedOn, lettersLastGeneratedOn)) &&
            (identical(other.reaffirmations, reaffirmations) ||
                const DeepCollectionEquality()
                    .equals(other.reaffirmations, reaffirmations)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dbId) ^
      const DeepCollectionEquality().hash(dbUiId) ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(emailVerified) ^
      const DeepCollectionEquality().hash(nickName) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(photoURL) ^
      const DeepCollectionEquality().hash(providerId) ^
      const DeepCollectionEquality().hash(affirmationLikes) ^
      const DeepCollectionEquality().hash(affirmations) ^
      const DeepCollectionEquality().hash(letterSchedule) ^
      const DeepCollectionEquality().hash(letters) ^
      const DeepCollectionEquality().hash(lettersLastGeneratedOn) ^
      const DeepCollectionEquality().hash(reaffirmations) ^
      runtimeType.hashCode;
}

extension $UserDtoExtension on UserDto {
  UserDto copyWith(
      {double? dbId,
      String? dbUiId,
      String? uid,
      String? displayName,
      String? email,
      bool? emailVerified,
      String? nickName,
      String? phoneNumber,
      String? photoURL,
      String? providerId,
      List<AffirmationLikeDto>? affirmationLikes,
      List<AffirmationDto>? affirmations,
      enums.UserDtoLetterSchedule? letterSchedule,
      List<LetterDto>? letters,
      DateTime? lettersLastGeneratedOn,
      List<ReaffirmationDto>? reaffirmations}) {
    return UserDto(
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
        reaffirmations: reaffirmations ?? this.reaffirmations);
  }
}

@JsonSerializable(explicitToJson: true)
class AffirmationDto {
  AffirmationDto({
    this.id,
    this.uiId,
    this.title,
    this.subtitle,
    this.active,
    this.createdBy,
    this.createdOn,
    this.likes,
    this.reaffirmations,
  });

  factory AffirmationDto.fromJson(Map<String, dynamic> json) =>
      _$AffirmationDtoFromJson(json);

  @JsonKey(name: 'id')
  final double? id;
  @JsonKey(name: 'uiId')
  final String? uiId;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'subtitle')
  final String? subtitle;
  @JsonKey(name: 'active')
  final bool? active;
  @JsonKey(name: 'createdBy')
  final UserDto? createdBy;
  @JsonKey(name: 'createdOn')
  final DateTime? createdOn;
  @JsonKey(name: 'likes', defaultValue: <AffirmationLikeDto>[])
  final List<AffirmationLikeDto>? likes;
  @JsonKey(name: 'reaffirmations', defaultValue: <ReaffirmationDto>[])
  final List<ReaffirmationDto>? reaffirmations;
  static const fromJsonFactory = _$AffirmationDtoFromJson;
  static const toJsonFactory = _$AffirmationDtoToJson;
  Map<String, dynamic> toJson() => _$AffirmationDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AffirmationDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uiId, uiId) ||
                const DeepCollectionEquality().equals(other.uiId, uiId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality()
                    .equals(other.createdOn, createdOn)) &&
            (identical(other.likes, likes) ||
                const DeepCollectionEquality().equals(other.likes, likes)) &&
            (identical(other.reaffirmations, reaffirmations) ||
                const DeepCollectionEquality()
                    .equals(other.reaffirmations, reaffirmations)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uiId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(createdOn) ^
      const DeepCollectionEquality().hash(likes) ^
      const DeepCollectionEquality().hash(reaffirmations) ^
      runtimeType.hashCode;
}

extension $AffirmationDtoExtension on AffirmationDto {
  AffirmationDto copyWith(
      {double? id,
      String? uiId,
      String? title,
      String? subtitle,
      bool? active,
      UserDto? createdBy,
      DateTime? createdOn,
      List<AffirmationLikeDto>? likes,
      List<ReaffirmationDto>? reaffirmations}) {
    return AffirmationDto(
        id: id ?? this.id,
        uiId: uiId ?? this.uiId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        active: active ?? this.active,
        createdBy: createdBy ?? this.createdBy,
        createdOn: createdOn ?? this.createdOn,
        likes: likes ?? this.likes,
        reaffirmations: reaffirmations ?? this.reaffirmations);
  }
}

@JsonSerializable(explicitToJson: true)
class AffirmationObjectResponseDto {
  AffirmationObjectResponseDto({
    this.affirmationData,
    this.liked,
  });

  factory AffirmationObjectResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AffirmationObjectResponseDtoFromJson(json);

  @JsonKey(name: 'affirmationData')
  final AffirmationDto? affirmationData;
  @JsonKey(name: 'liked')
  final bool? liked;
  static const fromJsonFactory = _$AffirmationObjectResponseDtoFromJson;
  static const toJsonFactory = _$AffirmationObjectResponseDtoToJson;
  Map<String, dynamic> toJson() => _$AffirmationObjectResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AffirmationObjectResponseDto &&
            (identical(other.affirmationData, affirmationData) ||
                const DeepCollectionEquality()
                    .equals(other.affirmationData, affirmationData)) &&
            (identical(other.liked, liked) ||
                const DeepCollectionEquality().equals(other.liked, liked)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(affirmationData) ^
      const DeepCollectionEquality().hash(liked) ^
      runtimeType.hashCode;
}

extension $AffirmationObjectResponseDtoExtension
    on AffirmationObjectResponseDto {
  AffirmationObjectResponseDto copyWith(
      {AffirmationDto? affirmationData, bool? liked}) {
    return AffirmationObjectResponseDto(
        affirmationData: affirmationData ?? this.affirmationData,
        liked: liked ?? this.liked);
  }
}

@JsonSerializable(explicitToJson: true)
class GetAffirmationListQueryResponseDto {
  GetAffirmationListQueryResponseDto({
    this.totalResults,
    this.results,
  });

  factory GetAffirmationListQueryResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$GetAffirmationListQueryResponseDtoFromJson(json);

  @JsonKey(name: 'totalResults')
  final double? totalResults;
  @JsonKey(name: 'results', defaultValue: <AffirmationObjectResponseDto>[])
  final List<AffirmationObjectResponseDto>? results;
  static const fromJsonFactory = _$GetAffirmationListQueryResponseDtoFromJson;
  static const toJsonFactory = _$GetAffirmationListQueryResponseDtoToJson;
  Map<String, dynamic> toJson() =>
      _$GetAffirmationListQueryResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetAffirmationListQueryResponseDto &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality()
                    .equals(other.totalResults, totalResults)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $GetAffirmationListQueryResponseDtoExtension
    on GetAffirmationListQueryResponseDto {
  GetAffirmationListQueryResponseDto copyWith(
      {double? totalResults, List<AffirmationObjectResponseDto>? results}) {
    return GetAffirmationListQueryResponseDto(
        totalResults: totalResults ?? this.totalResults,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateAffirmationCommandDto {
  CreateAffirmationCommandDto({
    this.title,
    this.subtitle,
  });

  factory CreateAffirmationCommandDto.fromJson(Map<String, dynamic> json) =>
      _$CreateAffirmationCommandDtoFromJson(json);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'subtitle')
  final String? subtitle;
  static const fromJsonFactory = _$CreateAffirmationCommandDtoFromJson;
  static const toJsonFactory = _$CreateAffirmationCommandDtoToJson;
  Map<String, dynamic> toJson() => _$CreateAffirmationCommandDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateAffirmationCommandDto &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subtitle) ^
      runtimeType.hashCode;
}

extension $CreateAffirmationCommandDtoExtension on CreateAffirmationCommandDto {
  CreateAffirmationCommandDto copyWith({String? title, String? subtitle}) {
    return CreateAffirmationCommandDto(
        title: title ?? this.title, subtitle: subtitle ?? this.subtitle);
  }
}

@JsonSerializable(explicitToJson: true)
class SignUpCommandDto {
  SignUpCommandDto({
    this.email,
    this.password,
    this.displayName,
    this.nickName,
  });

  factory SignUpCommandDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpCommandDtoFromJson(json);

  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'displayName')
  final String? displayName;
  @JsonKey(name: 'nickName')
  final String? nickName;
  static const fromJsonFactory = _$SignUpCommandDtoFromJson;
  static const toJsonFactory = _$SignUpCommandDtoToJson;
  Map<String, dynamic> toJson() => _$SignUpCommandDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SignUpCommandDto &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.nickName, nickName) ||
                const DeepCollectionEquality()
                    .equals(other.nickName, nickName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(nickName) ^
      runtimeType.hashCode;
}

extension $SignUpCommandDtoExtension on SignUpCommandDto {
  SignUpCommandDto copyWith(
      {String? email,
      String? password,
      String? displayName,
      String? nickName}) {
    return SignUpCommandDto(
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        nickName: nickName ?? this.nickName);
  }
}

String? reaffirmationDtoFontToJson(
    enums.ReaffirmationDtoFont? reaffirmationDtoFont) {
  return enums.$ReaffirmationDtoFontMap[reaffirmationDtoFont];
}

enums.ReaffirmationDtoFont reaffirmationDtoFontFromJson(
    Object? reaffirmationDtoFont) {
  if (reaffirmationDtoFont is int) {
    return enums.$ReaffirmationDtoFontMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() == reaffirmationDtoFont.toString(),
            orElse: () => const MapEntry(
                enums.ReaffirmationDtoFont.swaggerGeneratedUnknown, ''))
        .key;
  }

  if (reaffirmationDtoFont is String) {
    return enums.$ReaffirmationDtoFontMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() ==
                reaffirmationDtoFont.toLowerCase(),
            orElse: () => const MapEntry(
                enums.ReaffirmationDtoFont.swaggerGeneratedUnknown, ''))
        .key;
  }

  return enums.ReaffirmationDtoFont.swaggerGeneratedUnknown;
}

List<String> reaffirmationDtoFontListToJson(
    List<enums.ReaffirmationDtoFont>? reaffirmationDtoFont) {
  if (reaffirmationDtoFont == null) {
    return [];
  }

  return reaffirmationDtoFont
      .map((e) => enums.$ReaffirmationDtoFontMap[e]!)
      .toList();
}

List<enums.ReaffirmationDtoFont> reaffirmationDtoFontListFromJson(
    List? reaffirmationDtoFont) {
  if (reaffirmationDtoFont == null) {
    return [];
  }

  return reaffirmationDtoFont
      .map((e) => reaffirmationDtoFontFromJson(e.toString()))
      .toList();
}

String? reaffirmationDtoStampToJson(
    enums.ReaffirmationDtoStamp? reaffirmationDtoStamp) {
  return enums.$ReaffirmationDtoStampMap[reaffirmationDtoStamp];
}

enums.ReaffirmationDtoStamp reaffirmationDtoStampFromJson(
    Object? reaffirmationDtoStamp) {
  if (reaffirmationDtoStamp is int) {
    return enums.$ReaffirmationDtoStampMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() == reaffirmationDtoStamp.toString(),
            orElse: () => const MapEntry(
                enums.ReaffirmationDtoStamp.swaggerGeneratedUnknown, ''))
        .key;
  }

  if (reaffirmationDtoStamp is String) {
    return enums.$ReaffirmationDtoStampMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() ==
                reaffirmationDtoStamp.toLowerCase(),
            orElse: () => const MapEntry(
                enums.ReaffirmationDtoStamp.swaggerGeneratedUnknown, ''))
        .key;
  }

  return enums.ReaffirmationDtoStamp.swaggerGeneratedUnknown;
}

List<String> reaffirmationDtoStampListToJson(
    List<enums.ReaffirmationDtoStamp>? reaffirmationDtoStamp) {
  if (reaffirmationDtoStamp == null) {
    return [];
  }

  return reaffirmationDtoStamp
      .map((e) => enums.$ReaffirmationDtoStampMap[e]!)
      .toList();
}

List<enums.ReaffirmationDtoStamp> reaffirmationDtoStampListFromJson(
    List? reaffirmationDtoStamp) {
  if (reaffirmationDtoStamp == null) {
    return [];
  }

  return reaffirmationDtoStamp
      .map((e) => reaffirmationDtoStampFromJson(e.toString()))
      .toList();
}

String? reaffirmationDtoValueToJson(
    enums.ReaffirmationDtoValue? reaffirmationDtoValue) {
  return enums.$ReaffirmationDtoValueMap[reaffirmationDtoValue];
}

enums.ReaffirmationDtoValue reaffirmationDtoValueFromJson(
    Object? reaffirmationDtoValue) {
  if (reaffirmationDtoValue is int) {
    return enums.$ReaffirmationDtoValueMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() == reaffirmationDtoValue.toString(),
            orElse: () => const MapEntry(
                enums.ReaffirmationDtoValue.swaggerGeneratedUnknown, ''))
        .key;
  }

  if (reaffirmationDtoValue is String) {
    return enums.$ReaffirmationDtoValueMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() ==
                reaffirmationDtoValue.toLowerCase(),
            orElse: () => const MapEntry(
                enums.ReaffirmationDtoValue.swaggerGeneratedUnknown, ''))
        .key;
  }

  return enums.ReaffirmationDtoValue.swaggerGeneratedUnknown;
}

List<String> reaffirmationDtoValueListToJson(
    List<enums.ReaffirmationDtoValue>? reaffirmationDtoValue) {
  if (reaffirmationDtoValue == null) {
    return [];
  }

  return reaffirmationDtoValue
      .map((e) => enums.$ReaffirmationDtoValueMap[e]!)
      .toList();
}

List<enums.ReaffirmationDtoValue> reaffirmationDtoValueListFromJson(
    List? reaffirmationDtoValue) {
  if (reaffirmationDtoValue == null) {
    return [];
  }

  return reaffirmationDtoValue
      .map((e) => reaffirmationDtoValueFromJson(e.toString()))
      .toList();
}

String? userDtoLetterScheduleToJson(
    enums.UserDtoLetterSchedule? userDtoLetterSchedule) {
  return enums.$UserDtoLetterScheduleMap[userDtoLetterSchedule];
}

enums.UserDtoLetterSchedule userDtoLetterScheduleFromJson(
    Object? userDtoLetterSchedule) {
  if (userDtoLetterSchedule is int) {
    return enums.$UserDtoLetterScheduleMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() == userDtoLetterSchedule.toString(),
            orElse: () => const MapEntry(
                enums.UserDtoLetterSchedule.swaggerGeneratedUnknown, ''))
        .key;
  }

  if (userDtoLetterSchedule is String) {
    return enums.$UserDtoLetterScheduleMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() ==
                userDtoLetterSchedule.toLowerCase(),
            orElse: () => const MapEntry(
                enums.UserDtoLetterSchedule.swaggerGeneratedUnknown, ''))
        .key;
  }

  return enums.UserDtoLetterSchedule.swaggerGeneratedUnknown;
}

List<String> userDtoLetterScheduleListToJson(
    List<enums.UserDtoLetterSchedule>? userDtoLetterSchedule) {
  if (userDtoLetterSchedule == null) {
    return [];
  }

  return userDtoLetterSchedule
      .map((e) => enums.$UserDtoLetterScheduleMap[e]!)
      .toList();
}

List<enums.UserDtoLetterSchedule> userDtoLetterScheduleListFromJson(
    List? userDtoLetterSchedule) {
  if (userDtoLetterSchedule == null) {
    return [];
  }

  return userDtoLetterSchedule
      .map((e) => userDtoLetterScheduleFromJson(e.toString()))
      .toList();
}
