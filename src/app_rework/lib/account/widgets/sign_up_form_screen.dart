import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/account/widgets/sign_up_form.dart';
import 'package:repository/repository.dart';

class SignUpFormScreen extends StatelessWidget {
  const SignUpFormScreen({Key? key}) : super(key: key);

  static const String routeName = '/signUpFormScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpFormCubit>(
      create: (_) => SignUpFormCubit(
        apiClient: RepositoryProvider.of<ApiClient>(context),
        authRepo: RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: const Scaffold(
        body: SignUpForm(),
      ),
    );
  }
}
