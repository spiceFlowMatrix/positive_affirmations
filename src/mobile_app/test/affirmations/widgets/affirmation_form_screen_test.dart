import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/affirmation.dart';

void main() {
  late AffirmationsBloc affirmationsBloc;
  late AffirmationFormBloc affirmationFormBloc;
  final Affirmation toUpdateAffirmation =
      PositiveAffirmationsConsts.seedAffirmations[1];

  group('[AffirmationFormScreen]', () {});
}
