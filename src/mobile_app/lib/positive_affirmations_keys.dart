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

  // Affirmations tab body
  static const affirmationsList = Key('__affirmationsList__');
  static const affirmationsLoading = Key('__affirmationsLoading__');
  static final affirmationItem = (String id) => Key('AffirmationItem__$id');
  static final affirmationItemTitle =
      (String id) => Key('AffirmationItemTitle__$id');
  static final affirmationItemSubtitle =
      (String id) => Key('AffirmationItemSubtitle__$id');
  static final affirmationItemLikes =
      (String id) => Key('AffirmationItemLikes__$id');
  static final affirmationItemReaffirmationsCount =
      (String id) => Key('AffirmationItemReaffirmationsCount__$id');
  static final affirmationItemLikeButton =
      (String id) => Key('AffirmationItemLikeButton__$id');
  static final affirmationItemReaffirmButton =
      (String id) => Key('AffirmationItemReaffirmButton__$id');

  static const noAffirmationsWarningBody = Key('__noAffirmationsWarningBody__');
  static const noAffirmationsWarningIcon = Key('__noAffirmationsWarningIcon__');
  static const noAffirmationsWarningLabel =
      Key('__noAffirmationsWarningLabel__');
  static const noAffirmationsWarningButton =
      Key('__noAffirmationsWarningButton__');

  static const affirmationsAppbarTitle = Key('__affirmationsAppbarTitle__');
  static const affirmationsAppBarAddButton =
      Key('__affirmationsAppBarAddButton__');

  // Profile tab body
  static const profileDetails = Key('__profileDetails__');
  static const profileAppbarTitle = Key('__profileAppbarTitle__');
  static const profileAppbarEditButton = Key('__profileAppbarEditButton__');
  static final profilePicture = (String id) => Key('ProfilePicture__$id');
  static final profilePictureEmptyLabel =
      (String id) => Key('ProfilePictureEmptyLabel__$id');
  static final profilePictureImage =
      (String id) => Key('ProfilePictureImage__$id');
  static const profilePictureCameraIndicator =
      Key('__profilePictureCameraIndicator__');
  static final profileName = (String id) => Key('ProfileName__$id');
  static final profileNickName = (String id) => Key('ProfileNickName__$id');
  static final profileAffirmationsCount =
      (String id) => Key('ProfileAffirmationsCount__$id');
  static final profileLettersCount =
      (String id) => Key('ProfileLettersCount__$id');
  static final profileReaffirmationsCount =
      (String id) => Key('ProfileReaffirmationsCount__$id');
  static final profileAffirmationsSubtab =
      (String id) => Key('ProfileAffirmationsSubtab__$id');
  static final profileLettersSubtab =
      (String id) => Key('ProfileLettersSubtab__$id');
  static final profileAffirmationsSubtabBody =
      (String id) => Key('ProfileAffirmationsSubtabBody__$id');
  static final profileLettersSubtabBody =
      (String id) => Key('ProfileLettersSubtabBody__$id');

  // Add/Edit affirmation form
  static final affirmationFormBackButton = Key('__affirmationFormBackButton__');
  static const newAffirmationFormAppbarTitle =
      Key('__newAffirmationFormAppbarTitle__');
  static const editAffirmationFormAppbarTitle =
      Key('__editAffirmationFormAppbarTitle__');
  static const affirmationForm = Key('__affirmationForm__');
  static const affirmationFormTitleField = Key('__affirmationFormTitleField__');
  static const affirmationFormTitleFieldLabel =
      Key('__affirmationFormTitleFieldLabel__');
  static const affirmationFormSubtitleField =
      Key('__affirmationFormSubtitleField__');
  static const affirmationFormSubtitleFieldLabel =
      Key('__affirmationFormSubtitleFieldLabel__');
  static const affirmationFormSaveButton = Key('__affirmationFormSaveButton__');
  static final affirmationFormDeactivateDeactivateButton =
      (String id) => Key('__affirmationFormDeactivateDeactivateButton__$id');
  static final affirmationFormDeleteButton =
      (String id) => Key('__affirmationFormDeleteButton__$id');

  // Affirmation details screen
  static final affirmationDetailsBackButton =
      (String id) => Key('__affirmationDetailsBackButton__$id');
  static const affirmationDetailsAppbarTitle =
      Key('__affirmationDetailsAppbarTitle__');
  static final affirmationDetailsAppbarEditButton =
      (String id) => Key('__affirmationDetailsAppbarEditButton__$id');
  static final affirmationDetailsTitle =
      (String id) => Key('__affirmationDetailsTitle__$id');
  static final affirmationDetailsSubtitle =
      (String id) => Key('__affirmationDetailsSubtitle__$id');
  static final affirmationDetailsLikeButton =
      (String id) => Key('__affirmationDetailsLikeButton__$id');
  static final affirmationDetailsLikes =
      (String id) => Key('__affirmationDetailsLikes__$id');
  static final affirmationDetailsReaffirmationsCount =
      (String id) => Key('__affirmationDetailsReaffirmationsCount__$id');
  static final affirmationDetailsReaffirmButton =
      (String id) => Key('__affirmationDetailsReaffirmButton__$id');

  // Profile edit screen
  static const profileEditScreen = Key('__profileEditScreen__');
  static const profileEditScreenTitle = Key('__profileEditScreenTitle__');
  static final profileEditForm = (String id) => Key('ProfileEditForm__$id');
  static final profileEditNameField =
      (String id) => Key('ProfileEditNameField__$id');
  static const profileEditNameFieldLabel = Key('__profileEditNameFieldLabel__');
  static final profileEditNickNameField =
      (String id) => Key('ProfileEditNickNameField__$id');
  static const profileEditNickNameFieldLabel =
      Key('__profileEditNickNameFieldLabel__');
  static final profileEditSaveButton =
      (String id) => Key('ProfileEditSaveButton__$id');

  // Tabs
  static const homeTab = Key('__homeTab__');
  static const homeTabLabel = Key('__homeTabLabel__');
  static const homeTabIcon = Key('__homeTabIcon__');
  static const profileTab = Key('__profileTab__');
  static const profileTabLabel = Key('__profileTabLabel__');
  static const profileTabIcon = Key('__profileTabIcon__');

  // Snackbars
  static const underConstructionSnackbar = Key('__underConstructionSnackbar__');
}
