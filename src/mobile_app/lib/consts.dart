import 'package:repository/repository.dart';

class PositiveAffirmationsConsts {
  static const User seedUser = User(
    id: 'er34',
    name: 'test user',
  );
  static const User seedUserWithPicture = User(
      id: 'wef345',
      name: 'pictured user',
      pictureB64Enc:
          'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAMAAACdt4HsAAAAsVBMVEUAAABUxfhUxfhUxfhUxfhUxfhUxfhUxfhUxfgptvY6vPcptvYptvYNYJgptvYBV5sGVo4BV5sBV5sBV5tUxfgptvY5vPcindYinNUGVIwBVZgimtIGUogBVJcBV5oBV5shl84GTYEBUpIBVpkgkscFRnUBTYoBU5QBVpgfi70EPGQBRn0BTosBU5MBVpoeiboDL08BO2kBTYkBU5UDLkwAL1MBP3EBT40DNVkBRXoBVZl6N1VoAAAAFHRSTlMAj79gnyBAMO8w7++Pr5+fn4+/YK72X2UAAADgSURBVFjD7dfHEoIwFIVhVBQ7NiyoxN5Qsbf3fzAZBjLJdSE3YaU528z3r2807T+WSsNlUF5vwenKK6+88sorL+GzOTgD5Y08fMkbyfvPANJ/FNAeFAQ8VxDyTCHyhSLK0wL1JauN8mGB8RZf+OqDAue5QgzvF4BnCrE8HfW0IOzDgoQPClLeL+C8Vgbe6lSQx22V992ebcoU+oOhQyQKo/Fk6hDxwmy+WK78gGhhvXG3O3tPRAve4eiezoEXKniX6+2+ItHQBe/xnBB22ELtRcCwBZOoQjKFegOu+Uv/6jfzUGJCqyD6BgAAAABJRU5ErkJggg==');
  static final List<Affirmation> seedAffirmations = [
    Affirmation(
      id: 1,
      title: 'title 1',
      subtitle: 'subtitle 1',
      createdById: seedUser.id,
      createdOn: DateTime.utc(0),
    ),
    Affirmation(
      id: 2,
      title: 'title 2',
      subtitle: 'subtitle 2',
      createdById: seedUser.id,
      createdOn: DateTime.utc(0),
    ),
    Affirmation(
      id: 3,
      title: 'title 3',
      subtitle: 'subtitle 3',
      createdById: seedUser.id,
      createdOn: DateTime.utc(0),
    ),
    Affirmation(
      id: 4,
      title: 'title 4',
      createdById: seedUser.id,
      createdOn: DateTime.utc(0),
    ),
  ];

  static const String titleFieldEmptyError = 'Title is required';
  static const String titleFieldInvalidError = 'Invalid title';
  static const String subtitleFieldInvalidError = 'Invalid subtitle';

  static const String nameFieldEmptyError =
      'Come on, I\'d like to know your name';
  static const String nameFieldInvalidError =
      'Apologies, my rule-set cannot allow names like that.\nPlease let the devs know if you\'d like it otherwise.';
  static const String nickNameFieldInvalidError =
      'Apologies, my rule-set cannot allow nicknames like that.\nPlease let the devs know if you\'d like it otherwise.';

  static const String underConstructionSnackbarText = 'UNDER CONSTRUCTION';

  static const String profileEditTitle = 'Edit Affirmation';
  static const String profileEditNameFieldLabel = 'Your name';
  static const String profileEditNickNameFieldLabel =
      'What would you like me to call you?';
}
