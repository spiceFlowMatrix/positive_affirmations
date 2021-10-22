import 'package:app/account_setup/widgets/already_have_account_content.dart';
import 'package:app/consts.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[AlreadyHaveAccountLabel]', () {
    testWidgets('[key and correct text exists]', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Center(
            child: AlreadyHaveAccountLabel(),
          ),
        ),
      ));

      expect(
        find.byKey(PositiveAffirmationsKeys.alreadyHaveAccountLabel),
        findsOneWidget,
      );

      final textWidget = tester.widget<Text>(
          find.byKey(PositiveAffirmationsKeys.alreadyHaveAccountLabel));

      expect(
        textWidget.data,
        equals(PositiveAffirmationsConsts.alreadyHaveAccountLabelText),
      );
    });
  });

  group('[AlreadyHaveAccountSignInButton]', () {
    testWidgets('key and correct text exists', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Center(
            child: AlreadyHaveAccountSignInButton(),
          ),
        ),
      ));

      expect(
        find.byKey(PositiveAffirmationsKeys.alreadyHaveAccountSignInButton),
        findsOneWidget,
      );

      final buttonWidget = tester.widget<OutlinedButton>(
          find.byKey(PositiveAffirmationsKeys.alreadyHaveAccountSignInButton));
      final buttonText = buttonWidget.child as Text;

      expect(
        buttonText.data,
        equals(PositiveAffirmationsConsts.alreadyHaveAccountSignInButtonText),
      );
    });
  });
}
