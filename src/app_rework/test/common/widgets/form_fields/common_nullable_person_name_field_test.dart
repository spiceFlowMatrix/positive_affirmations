import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_nullable_person_name_field.dart';

import '../fixtures/common_form_fields_fixture.dart';

void main() {
  const initValidName = NullablePersonNameField.dirty('Valid name');
  const initInvalidName = NullablePersonNameField.dirty('!nv@l1d.n@mE');
  group('[CommonNullablePersonNameField]', () {
    testWidgets(
      'initial value is set to value of passed name',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [CommonNullablePersonNameField(name: initValidName)],
          ),
        );

        final textField =
            tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.initialValue, isNotNull);
        expect(textField.initialValue, equals(initValidName.value));
      },
    );

    testWidgets(
      'onChanged event triggers upon input',
      (WidgetTester tester) async {
        String testValue = '';
        String inputValue = 'test name';
        await tester.pumpWidget(
          CommonFormFieldsFixture(
            children: [
              CommonNullablePersonNameField(
                name: const NullablePersonNameField.pure(),
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
      'does not show error if value is pure',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [
              CommonNullablePersonNameField(
                name: NullablePersonNameField.pure(),
              ),
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
      'does not show error if dirty name has empty value',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [
              CommonNullablePersonNameField(
                name: NullablePersonNameField.dirty(''),
              ),
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
      'does not show error if dirty name has null value',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [
              CommonNullablePersonNameField(
                name: NullablePersonNameField.dirty(null),
              ),
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
              CommonNullablePersonNameField(
                name: initInvalidName,
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
