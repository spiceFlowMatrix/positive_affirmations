import 'package:flutter/widgets.dart';
import 'package:positive_affirmations/account/bloc/widgets/sign_up_form.dart';

Map<String, Widget Function(BuildContext context)> namedRoutes(
    BuildContext context) {
  return {
    SignUpForm.routeName: (context) => const SignUpForm(),
  };
}
