// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AffirmationLikeDto _$AffirmationLikeDtoFromJson(Map<String, dynamic> json) =>
    AffirmationLikeDto(
      id: (json['id'] as num?)?.toDouble(),
      uiId: json['uiId'] as String?,
      byUser: json['byUser'] == null
          ? null
          : UserDto.fromJson(json['byUser'] as Map<String, dynamic>),
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
    );

Map<String, dynamic> _$AffirmationLikeDtoToJson(AffirmationLikeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uiId': instance.uiId,
      'byUser': instance.byUser?.toJson(),
      'createdOn': instance.createdOn?.toIso8601String(),
    };

ReaffirmationDto _$ReaffirmationDtoFromJson(Map<String, dynamic> json) =>
    ReaffirmationDto(
      id: (json['id'] as num?)?.toDouble(),
      uiId: json['uiId'] as String?,
      font: reaffirmationDtoFontFromJson(json['font']),
      stamp: reaffirmationDtoStampFromJson(json['stamp']),
      value: reaffirmationDtoValueFromJson(json['value']),
      createdBy: json['createdBy'] == null
          ? null
          : UserDto.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      forAffirmation: json['forAffirmation'] == null
          ? null
          : AffirmationDto.fromJson(
              json['forAffirmation'] as Map<String, dynamic>),
      inLetters: (json['inLetters'] as List<dynamic>?)
              ?.map((e) => LetterDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ReaffirmationDtoToJson(ReaffirmationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uiId': instance.uiId,
      'font': reaffirmationDtoFontToJson(instance.font),
      'stamp': reaffirmationDtoStampToJson(instance.stamp),
      'value': reaffirmationDtoValueToJson(instance.value),
      'createdBy': instance.createdBy?.toJson(),
      'createdOn': instance.createdOn?.toIso8601String(),
      'forAffirmation': instance.forAffirmation?.toJson(),
      'inLetters': instance.inLetters?.map((e) => e.toJson()).toList(),
    };

LetterDto _$LetterDtoFromJson(Map<String, dynamic> json) => LetterDto(
      id: (json['id'] as num?)?.toDouble(),
      uiId: json['uiId'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : UserDto.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      opened: json['opened'] as bool?,
      openedOn: json['openedOn'] == null
          ? null
          : DateTime.parse(json['openedOn'] as String),
      reaffirmations: (json['reaffirmations'] as List<dynamic>?)
              ?.map((e) => ReaffirmationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LetterDtoToJson(LetterDto instance) => <String, dynamic>{
      'id': instance.id,
      'uiId': instance.uiId,
      'createdBy': instance.createdBy?.toJson(),
      'createdOn': instance.createdOn?.toIso8601String(),
      'opened': instance.opened,
      'openedOn': instance.openedOn?.toIso8601String(),
      'reaffirmations':
          instance.reaffirmations?.map((e) => e.toJson()).toList(),
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      dbId: (json['dbId'] as num?)?.toDouble(),
      dbUiId: json['dbUiId'] as String?,
      uid: json['uid'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      nickName: json['nickName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      providerId: json['providerId'] as String?,
      affirmationLikes: (json['affirmationLikes'] as List<dynamic>?)
              ?.map(
                  (e) => AffirmationLikeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      affirmations: (json['affirmations'] as List<dynamic>?)
              ?.map((e) => AffirmationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      letterSchedule: userDtoLetterScheduleFromJson(json['letterSchedule']),
      letters: (json['letters'] as List<dynamic>?)
              ?.map((e) => LetterDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lettersLastGeneratedOn: json['lettersLastGeneratedOn'] == null
          ? null
          : DateTime.parse(json['lettersLastGeneratedOn'] as String),
      reaffirmations: (json['reaffirmations'] as List<dynamic>?)
              ?.map((e) => ReaffirmationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'dbId': instance.dbId,
      'dbUiId': instance.dbUiId,
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'nickName': instance.nickName,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'providerId': instance.providerId,
      'affirmationLikes':
          instance.affirmationLikes?.map((e) => e.toJson()).toList(),
      'affirmations': instance.affirmations?.map((e) => e.toJson()).toList(),
      'letterSchedule': userDtoLetterScheduleToJson(instance.letterSchedule),
      'letters': instance.letters?.map((e) => e.toJson()).toList(),
      'lettersLastGeneratedOn':
          instance.lettersLastGeneratedOn?.toIso8601String(),
      'reaffirmations':
          instance.reaffirmations?.map((e) => e.toJson()).toList(),
    };

AffirmationDto _$AffirmationDtoFromJson(Map<String, dynamic> json) =>
    AffirmationDto(
      id: (json['id'] as num?)?.toDouble(),
      uiId: json['uiId'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      active: json['active'] as bool?,
      createdBy: json['createdBy'] == null
          ? null
          : UserDto.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      likes: (json['likes'] as List<dynamic>?)
              ?.map(
                  (e) => AffirmationLikeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      reaffirmations: (json['reaffirmations'] as List<dynamic>?)
              ?.map((e) => ReaffirmationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AffirmationDtoToJson(AffirmationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uiId': instance.uiId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'active': instance.active,
      'createdBy': instance.createdBy?.toJson(),
      'createdOn': instance.createdOn?.toIso8601String(),
      'likes': instance.likes?.map((e) => e.toJson()).toList(),
      'reaffirmations':
          instance.reaffirmations?.map((e) => e.toJson()).toList(),
    };

AffirmationObjectResponseDto _$AffirmationObjectResponseDtoFromJson(
        Map<String, dynamic> json) =>
    AffirmationObjectResponseDto(
      affirmationData: json['affirmationData'] == null
          ? null
          : AffirmationDto.fromJson(
              json['affirmationData'] as Map<String, dynamic>),
      liked: json['liked'] as bool?,
    );

Map<String, dynamic> _$AffirmationObjectResponseDtoToJson(
        AffirmationObjectResponseDto instance) =>
    <String, dynamic>{
      'affirmationData': instance.affirmationData?.toJson(),
      'liked': instance.liked,
    };

GetAffirmationListQueryResponseDto _$GetAffirmationListQueryResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GetAffirmationListQueryResponseDto(
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => AffirmationObjectResponseDto.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAffirmationListQueryResponseDtoToJson(
        GetAffirmationListQueryResponseDto instance) =>
    <String, dynamic>{
      'totalResults': instance.totalResults,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

CreateAffirmationCommandDto _$CreateAffirmationCommandDtoFromJson(
        Map<String, dynamic> json) =>
    CreateAffirmationCommandDto(
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$CreateAffirmationCommandDtoToJson(
        CreateAffirmationCommandDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
    };

SignUpCommandDto _$SignUpCommandDtoFromJson(Map<String, dynamic> json) =>
    SignUpCommandDto(
      email: json['email'] as String?,
      password: json['password'] as String?,
      displayName: json['displayName'] as String?,
      nickName: json['nickName'] as String?,
    );

Map<String, dynamic> _$SignUpCommandDtoToJson(SignUpCommandDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'displayName': instance.displayName,
      'nickName': instance.nickName,
    };
