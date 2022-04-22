import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/email_field.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_email_form_field.dart';

import '../fixtures/common_form_fields_fixture.dart';

void main() {
  const initEmail = EmailField.dirty('test@email.com');
  group('[CommonEmailFormField]', () {
    testWidgets(
      'initial value is set to value of passed email',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [CommonEmailFormField(email: initEmail)],
          ),
        );

        final textField =
            tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.initialValue, isNotNull);
        expect(textField.initialValue, equals(initEmail.value));
      },
    );
  });
}
