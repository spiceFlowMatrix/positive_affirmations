import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/account/widgets/sign_up_form_screen.dart';
import 'package:repository/repository.dart';

import '../../common/blocs/app/app_bloc_test.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('[SignUpFormScreen]', () {
    testWidgets(
      'renders a [SignUpForm]',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthenticationRepository>(
                create: (_) => MockAuthenticationRepository(),
              ),
              RepositoryProvider<ApiClient>(
                create: (_) => MockApiClient(),
              ),
            ],
            child: const MaterialApp(
              home: SignUpFormScreen(),
            ),
          ),
        );
      },
    );
  });
}
