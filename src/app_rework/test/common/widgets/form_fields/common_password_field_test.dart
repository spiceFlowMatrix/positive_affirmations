import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:positive_affirmations/common/models/form_fields/form_fields.dart';
import 'package:positive_affirmations/common/widgets/form_fields/common_password_field.dart';

import '../fixtures/common_form_fields_fixture.dart';

void main() {
  const initValidPassword = PasswordField.dirty('1234567As');
  const initInvalidPassword = PasswordField.dirty('1.2@3#.\$5%6^7&8*9()\\/');
  group('[CommonPasswordField]', () {
    testWidgets(
      'initial value is set to value of passed name',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CommonFormFieldsFixture(
            children: [CommonPasswordField(password: initValidPassword)],
          ),
        );

        final textField =
            tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.initialValue, isNotNull);
        expect(textField.initialValue, equals(initValidPassword.value));
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
              CommonPasswordField(
                password: const PasswordField.pure(),
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
              CommonPasswordField(
                password: PasswordField.pure(),
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
      'given `TextField` is unfocused, empty error message appears',
      (WidgetTester tester) async {
        final FocusNode focusNode = FocusNode();
        await tester.pumpWidget(
          CommonFormFieldsFixture(
            children: [
              CommonPasswordField(
                password: const PasswordField.dirty(''),
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

    testWidgets(
      'given `TextField` is unfocused, invalid error message appears',
      (WidgetTester tester) async {
        final FocusNode focusNode = FocusNode();
        await tester.pumpWidget(
          CommonFormFieldsFixture(
            children: [
              CommonPasswordField(
                password: initInvalidPassword,
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

    testWidgets(
      'given `TextField` is unfocused, and value of `confirmingPassword` does not match field value, shows passwords don\'t match error',
      (WidgetTester tester) async {
        final FocusNode focusNode = FocusNode();
        await tester.pumpWidget(
          CommonFormFieldsFixture(
            children: [
              CommonPasswordField(
                password: initValidPassword,
                confirmingPassword:
                    PasswordField.dirty(initValidPassword.value + 'Suffix'),
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
