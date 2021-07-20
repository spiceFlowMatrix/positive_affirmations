import 'package:flutter/material.dart';
import 'package:mobile_app/account_setup/widgets/app_summary_screen.dart';
import 'package:mobile_app/account_setup/widgets/name_form_screen.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form_screen.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_detail_screen.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:mobile_app/affirmations/widgets/affirmations_home_screen.dart';

class PositiveAffirmationsRoutes {
  Map<String, Widget Function(BuildContext context)> routes(
      BuildContext context) {
    return {
      NameFormScreen.routeName: (context) => NameFormScreen(),
      NickNameFormScreen.routeName: (context) => NickNameFormScreen(),
      AppSummaryScreen.routeName: (context) => AppSummaryScreen(),
      AffirmationsHomeScreen.routeName: (context) => AffirmationsHomeScreen(),
      AffirmationFormScreen.routeName: (context) => AffirmationFormScreen(),
      AffirmationDetailScreen.routeName: (context) => AffirmationDetailScreen(),
    };
  }
}
