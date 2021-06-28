import 'package:flutter/widgets.dart';

class PositiveAffirmationsKeys {
  // Account setup screens
  static const nameFormScreen = Key('__nameFormScreen__');
  static const nickNameFormScreen = Key('__nickNameFormScreen__');
  static const appSummaryScreen = Key('__appSummaryScreen__');

  // Account setup
  static const nameField = Key('__nameField__');
  static const nameFieldLabel = Key('__nameFieldLabel__');
  static const nameSubmitButton = Key('__nameSubmitButton__');
  static const nickNameField = Key('__nickNameField__');
  static const nickNameFieldLabel = Key('__nickNameFieldLabel__');
  static const nickNameSubmitButton = Key('__nickNameSubmitButton__');
  static const changeNameButton = Key('__changeNameButton__');
  static const appSummaryUserNameHeader = Key('__appSummaryUserNameHeader__');
  static const appSummaryHeader = Key('__appSummaryHeader__');
  static const appSummarySubheader = Key('__appSummarySubheader__');
  static const appSummaryAnimatedBody = Key('__appSummaryAnimatedBody__');
  static const changeNickNameButton = Key('__changeNickNameButton__');
  static const skipAppSummaryButton = Key('__skipAppSummaryButton__');

  // App summary animated text bodies

  static const cheerleaderTitle = Key('__cheerleaderTitle__');
  static const cheerleaderBody = Key('__cheerleaderBody__');
  static const awesomenessTitle = Key('__awesomenessTitle__');
  static const awesomenessBody = Key('__awesomenessBody__');
  static const honestTitle = Key('__honestTitle__');
  static const honestBody = Key('__honestBody__');
  static const spreadWordTitle = Key('__spreadWordTitle__');
  static const spreadWordBody = Key('__spreadWordBody__');

  // Affirmations
  static const affirmationsList = Key('__affirmationsList__');
  static const affirmationsLoading = Key('__affirmationsLoading__');
  static final affirmationItem = (String id) => Key('AffirmationItem__$id');
  static final affirmationItemLikeButton =
      (String id) => Key('AffirmationItemLikeButton__$id');
  static final affirmationItemTitle =
      (String id) => Key('AffirmationItemTitle__$id');
  static final affirmationItemSubtitle =
      (String id) => Key('AffirmationItemSubtitle__$id');
  static final affirmationItemLikes =
      (String id) => Key('AffirmationItemLikes__$id');
  static final affirmationItemReaffirmationsCount =
      (String id) => Key('AffirmationItemReaffirmationsCount__$id');
  static const addNewAffirmationAction = Key('__addNewAffirmationAction__');

  // Tabs
  static const homeTab = Key('__homeTab__');
  static const profileTab = Key('__profileTab__');
}
