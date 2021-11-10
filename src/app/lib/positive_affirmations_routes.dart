import 'package:app/affirmations/widgets/affirmation_detail_screen.dart';
import 'package:app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:app/affirmations/widgets/affirmations_home_screen.dart';
import 'package:app/app_account/widgets/auth_landing.dart';
import 'package:app/app_account/widgets/sign_in_screen.dart';
import 'package:app/app_account/widgets/verification_flow.dart';
import 'package:app/app_account/widgets/widgets.dart';
import 'package:app/profile/widgets/profile_edit_form.dart';
import 'package:app/profile/widgets/profile_options_screen.dart';
import 'package:app/reaffirmation/widgets/reaffirmation_form_screen.dart';
import 'package:flutter/material.dart';

class PositiveAffirmationsRoutes {
  Map<String, Widget Function(BuildContext context)> routes(
      BuildContext context) {
    return {
      AffirmationsHomeScreen.routeName: (context) =>
          const AffirmationsHomeScreen(),
      AffirmationFormScreen.routeName: (context) => const AffirmationFormScreen(),
      AffirmationDetailScreen.routeName: (context) => AffirmationDetailScreen(),
      ProfileEditForm.routeName: (context) => ProfileEditForm(),
      ReaffirmationFormScreen.routeName: (context) => ReaffirmationFormScreen(),
      SignUpFlow.routeName: (context) => const SignUpFlow(),
      VerificationFlow.routeName: (context) => const VerificationFlow(),
      SignInScreen.routeName: (context) => const SignInScreen(),
      ProfileOptionsScreen.routeName: (context) => const ProfileOptionsScreen(),
      AuthLanding.routeName: (context) => const AuthLanding(),
    };
  }
}
