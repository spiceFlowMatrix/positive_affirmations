import 'package:json_annotation/json_annotation.dart';

enum ReaffirmationDtoFont {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('none')
  none,
  @JsonValue('birthstone')
  birthstone,
  @JsonValue('gemunuLibre')
  gemunulibre,
  @JsonValue('montserrat')
  montserrat
}

const $ReaffirmationDtoFontMap = {
  ReaffirmationDtoFont.none: 'none',
  ReaffirmationDtoFont.birthstone: 'birthstone',
  ReaffirmationDtoFont.gemunulibre: 'gemunuLibre',
  ReaffirmationDtoFont.montserrat: 'montserrat'
};

enum ReaffirmationDtoStamp {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('empty')
  empty,
  @JsonValue('takeOff')
  takeoff,
  @JsonValue('medal')
  medal,
  @JsonValue('thumbsUp')
  thumbsup
}

const $ReaffirmationDtoStampMap = {
  ReaffirmationDtoStamp.empty: 'empty',
  ReaffirmationDtoStamp.takeoff: 'takeOff',
  ReaffirmationDtoStamp.medal: 'medal',
  ReaffirmationDtoStamp.thumbsup: 'thumbsUp'
};

enum ReaffirmationDtoValue {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('empty')
  empty,
  @JsonValue('braveOn')
  braveon,
  @JsonValue('loveIt')
  loveit,
  @JsonValue('goodWork')
  goodwork
}

const $ReaffirmationDtoValueMap = {
  ReaffirmationDtoValue.empty: 'empty',
  ReaffirmationDtoValue.braveon: 'braveOn',
  ReaffirmationDtoValue.loveit: 'loveIt',
  ReaffirmationDtoValue.goodwork: 'goodWork'
};

enum UserDtoLetterSchedule {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('never')
  never
}

const $UserDtoLetterScheduleMap = {
  UserDtoLetterSchedule.daily: 'daily',
  UserDtoLetterSchedule.weekly: 'weekly',
  UserDtoLetterSchedule.monthly: 'monthly',
  UserDtoLetterSchedule.never: 'never'
};
