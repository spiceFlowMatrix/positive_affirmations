import 'package:flutter/widgets.dart';
import 'package:positive_affirmations/account/widgets/sign_in_form_screen.dart';
import 'package:positive_affirmations/account/widgets/sign_up_form_screen.dart';
import 'package:positive_affirmations/home/widgets/home_screen.dart';

Map<String, Widget Function(BuildContext context)> namedRoutes(
    BuildContext context) {
  return {
    SignUpFormScreen.routeName: (context) => const SignUpFormScreen(),
    SignInFormScreen.routeName: (context) => const SignInFormScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
  };
}
