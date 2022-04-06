import 'package:flutter/widgets.dart';
import 'package:positive_affirmations/account/bloc/widgets/sign_in_form.dart';
import 'package:positive_affirmations/account/bloc/widgets/sign_up_form.dart';
import 'package:positive_affirmations/home/widgets/home_screen.dart';

Map<String, Widget Function(BuildContext context)> namedRoutes(
    BuildContext context) {
  return {
    SignUpForm.routeName: (context) => const SignUpForm(),
    SignInForm.routeName: (context) => const SignInForm(),
    HomeScreen.routeName: (context) => const HomeScreen(),
  };
}
