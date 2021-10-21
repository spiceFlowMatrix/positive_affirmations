import 'package:app/account_setup/widgets/app_summary_screen.dart';
import 'package:app/account_setup/widgets/nick_name_form_screen.dart';
import 'package:app/account_setup/widgets/sign_up_flow.dart';
import 'package:app/affirmations/widgets/affirmation_detail_screen.dart';
import 'package:app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:app/affirmations/widgets/affirmations_home_screen.dart';
import 'package:app/profile/widgets/profile_edit_form.dart';
import 'package:app/reaffirmation/widgets/reaffirmation_form_screen.dart';
import 'package:flutter/material.dart';

class PositiveAffirmationsRoutes {
  Map<String, Widget Function(BuildContext context)> routes(
      BuildContext context) {
    return {
      NickNameFormScreen.routeName: (context) => NickNameFormScreen(),
      AppSummaryScreen.routeName: (context) => AppSummaryScreen(),
      AffirmationsHomeScreen.routeName: (context) =>
          const AffirmationsHomeScreen(),
      AffirmationFormScreen.routeName: (context) => AffirmationFormScreen(),
      AffirmationDetailScreen.routeName: (context) => AffirmationDetailScreen(),
      ProfileEditForm.routeName: (context) => ProfileEditForm(),
      ReaffirmationFormScreen.routeName: (context) => ReaffirmationFormScreen(),
      SignUpFlow.routeName: (context) => const SignUpFlow(),
    };
  }
}
