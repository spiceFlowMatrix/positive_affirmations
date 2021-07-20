import 'package:mobile_app/models/affirmation.dart';
import 'package:mobile_app/models/models.dart';

class PositiveAffirmationsConsts {
  static const User seedUser = User(
    id: 'er34',
    name: 'test user',
  );
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
  ];

  static const String titleFieldEmptyError = 'Title is required';
  static const String titleFieldInvalidError = 'Invalid title';
  static const String subtitleFieldInvalidError = 'Invalid subtitle';

  static const String underConstructionSnackbarText = 'UNDER CONSTRUCTION';
}
