import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repository/repository.dart';

const String applicationName = 'Positive Affirmations';

class PositiveAffirmationsConsts {
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

  static const String reaffirmationFormScreenTitleValue = 'Reaffirmation';
  static const String reaffirmationFormPreviewPanelEmptyLabel =
      'Please select a Note and Font below';
  static const String reaffirmationFormPreviewPanelSubmitButtonValue =
      'Reaffirm';
  static const String reaffirmationFormNoteTabTitle = 'NOTE';
  static const String reaffirmationFormFontTabTitle = 'FONT';
  static const String reaffirmationFormStampTabTitle = 'STAMP';

  static final reaffirmationNoteValue = (ReaffirmationValue value) {
    switch (value) {
      case ReaffirmationValue.empty:
        return 'None';
      case ReaffirmationValue.braveOn:
        return 'Brave on!';
      case ReaffirmationValue.loveIt:
        return 'Love it!';
      case ReaffirmationValue.goodWork:
        return 'Great work!';
    }
  };

  static final reaffirmationFontValue = (ReaffirmationFont font) {
    switch (font) {
      case ReaffirmationFont.none:
        return 'Roboto';
      case ReaffirmationFont.birthstone:
        return 'Birthstone';
      case ReaffirmationFont.gemunuLibre:
        return 'Gemunu Libre';
      case ReaffirmationFont.montserrat:
        return 'Montserrat';
    }
  };

  static final reaffirmationStampValue = (ReaffirmationStamp stamp) {
    switch (stamp) {
      case ReaffirmationStamp.empty:
        return {'None': ''};
      case ReaffirmationStamp.takeOff:
        return {'Take-off!': '🛫'};
      case ReaffirmationStamp.medal:
        return {'Medal': '🏅'};
      case ReaffirmationStamp.thumbsUp:
        return {'Thumbs-up': '👍'};
    }
  };

  static const String alreadyHaveAccountLabelText = 'Already have an account?';
  static const String alreadyHaveAccountSignInButtonText = 'Sign In';

  static const String invalidEmailErrorText = 'E.g., "sample@email.com".';

  static const String verifyAccountMessageTitle = 'Account not verified';
  static const String verifyAccountMessageContent =
      'Please check your email for a verification link. Clicking it will complete your account creation process';
  static const FaIcon verifyAccountMessageIcon =
      FaIcon(FontAwesomeIcons.fingerprint);
}
