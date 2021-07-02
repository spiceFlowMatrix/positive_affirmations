import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/affirmation.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/affirmation_form_bloc_mock.dart';
import '../../mocks/affirmations_bloc_mock.dart';
import '../fixtures/affirmation_form_screen_fixture.dart';

void main() {
  late AffirmationsBloc affirmationsBloc;
  late AffirmationFormBloc affirmationFormBloc;
  final Affirmation toUpdateAffirmation =
      PositiveAffirmationsConsts.seedAffirmations[1];

  setUpAll(() {
    registerFallbackValue<AffirmationsState>(FakeAffirmationsState());
    registerFallbackValue<AffirmationsEvent>(FakeAffirmationsEvent());
    registerFallbackValue<AffirmationFormState>(FakeAffirmationFormState());
    registerFallbackValue<AffirmationFormEvent>(FakeAffirmationFormEvent());
  });

  setUp(() {
    affirmationsBloc = MockAffirmationsBloc();
    affirmationFormBloc = MockAffirmationFormBloc();
  });

  group('[AffirmationFormScreen]', () {
    testWidgets('all components exist', (tester) async {
      await tester.pumpWidget(
          AffirmationFormScreenFixture(affirmationsBloc: affirmationsBloc));
    });
  });
}
