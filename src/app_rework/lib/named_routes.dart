import 'package:flutter/widgets.dart';
import 'package:positive_affirmations/account_setup/widgets/auth_landing.dart';
import 'package:positive_affirmations/account_setup/widgets/sign_up_flow.dart';
import 'package:positive_affirmations/common/widgets/home_scaffold.dart';

Map<String, Widget Function(BuildContext context)> namedRoutes(
    BuildContext context) {
  return {
    HomeScaffold.routeName: (context) => const HomeScaffold(),
    AuthLanding.routeName: (context) => const AuthLanding(),
    SignUpFlow.routeName: (context) => const SignUpFlow(),
  };
}
