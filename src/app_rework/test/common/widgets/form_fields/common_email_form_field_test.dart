import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/email_field.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_email_form_field.dart';

import '../fixtures/common_form_fields_fixture.dart';

void main() {
  const initEmail = EmailField.dirty('test@email.com');
  const initInvalidEmail = EmailField.dirty('test.com');
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

    testWidgets(
      'onChanged event triggers upon input',
      (WidgetTester tester) async {
        String testValue = '';
        String inputValue = 'test@email.com';
        await tester.pumpWidget(
          CommonFormFieldsFixture(
            children: [
              CommonEmailFormField(
                email: const EmailField.pure(),
                onChanged: (value) => testValue = value,
              )
            ],
          ),
        );

        await tester.enterText(find.byType(TextFormField), inputValue);
        expect(testValue, equals(inputValue));
      },
    );

    testWidgets(
      'does not show error if email is pure',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [
              CommonEmailFormField(email: EmailField.pure()),
            ],
          ),
        );

        expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .errorText,
          isNull,
        );
      },
    );

    testWidgets(
      'does not show error if dirty email has empty value',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [
              CommonEmailFormField(email: EmailField.dirty('')),
            ],
          ),
        );

        expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .errorText,
          isNull,
        );
      },
    );

    testWidgets(
      'error only appears when unfocused',
      (WidgetTester tester) async {
        final FocusNode focusNode = FocusNode();
        await tester.pumpWidget(
          CommonFormFieldsFixture(
            children: [
              CommonEmailFormField(
                email: initInvalidEmail,
                focusNode: focusNode,
              )
            ],
          ),
        );

        expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .errorText,
          isNotNull,
        );

        await tester.tap(find.byType(TextFormField));
        await tester.pumpAndSettle();
        expect(focusNode.hasFocus, isTrue);
        expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .errorText,
          isNull,
        );

        focusNode.unfocus();
        await tester.pumpAndSettle();
        expect(focusNode.hasFocus, isFalse);
        expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .errorText,
          isNotNull,
        );

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(focusNode.hasFocus, isTrue);
        expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .errorText,
          isNull,
        );
      },
    );
  });
}
