import 'package:api_client/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:repository/repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late ApiClient apiClient;
  late AuthenticationRepository authRepo;
  late SignUpFormCubit cubit;

  setUp(() {
    authRepo = MockAuthRepo();
    apiClient = MockApiClient();
    cubit = SignUpFormCubit(
      apiClient: apiClient,
      authRepo: authRepo,
    );
  });

  group('[SignUpFormCubit]', () {
    test('initial state is `SignUpFormState()`', () {
      expect(cubit.state, equals(const SignUpFormState()));
    });
  });
}
