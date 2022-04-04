import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';
import 'package:repository/repository.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  static const String routeName = '/signUpForm';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpFormCubit>(
      create: (_) => SignUpFormCubit(
        apiClient: RepositoryProvider.of<ApiClient>(context),
        authRepo: RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: const Scaffold(
        body: _Form(),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _NameField(),
            _NickNameField(),
            _EmailField(),
            _PasswordField(),
            _ConfirmPasswordField(),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _NameField extends StatefulWidget {
  const _NameField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  late FocusNode _focusNode;
  bool _canShowError = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _canShowError = !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CommonFormPadding(
          child: TextFormField(
            focusNode: _focusNode,
            initialValue: cubit.state.name.value,
            onChanged: (value) => cubit.updateName(value),
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              labelText: 'Name *',
              errorText:
                  _canShowError ? state.name.buildErrorText(context) : null,
            ),
          ),
        );
      },
    );
  }
}

class _NickNameField extends StatefulWidget {
  const _NickNameField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NickNameFieldState();
}

class _NickNameFieldState extends State<_NickNameField> {
  late FocusNode _focusNode;
  bool _canShowError = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _canShowError = !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.nickName != current.nickName,
      builder: (context, state) {
        return CommonFormPadding(
          child: TextFormField(
            focusNode: _focusNode,
            initialValue: cubit.state.name.value,
            onChanged: (value) => cubit.updateNickname(value),
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              labelText: 'Nick name',
              errorText:
                  _canShowError ? state.nickName.buildErrorText(context) : null,
            ),
          ),
        );
      },
    );
  }
}

class _EmailField extends StatefulWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<_EmailField> {
  late FocusNode _focusNode;
  bool _canShowError = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _canShowError = !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CommonFormPadding(
          child: TextFormField(
            focusNode: _focusNode,
            initialValue: cubit.state.email.value,
            onChanged: (value) => cubit.updateEmail(value),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email *',
              errorText:
                  _canShowError ? state.email.buildErrorText(context) : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();

    return CommonFormPadding(
      verticalPadding: 12,
      child: TextFormField(
        initialValue: cubit.state.password.value,
        textInputAction: TextInputAction.next,
        onChanged: (value) => cubit.updatePassword(value),
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password *',
          fillColor: Colors.white,
          filled: true,
          isDense: true,
        ),
      ),
    );
  }
}

class _ConfirmPasswordField extends StatefulWidget {
  const _ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<_ConfirmPasswordField> {
  late FocusNode _focusNode;
  bool _canShowError = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _canShowError = !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();

    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword ||
          previous.password != current.password,
      builder: (context, state) {
        return CommonFormPadding(
          verticalPadding: 12,
          child: TextFormField(
            focusNode: _focusNode,
            initialValue: cubit.state.confirmPassword.value,
            textInputAction: TextInputAction.done,
            onChanged: (value) => cubit.updateConfirmPassword(value),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm password *',
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              errorText: _canShowError && state.showPasswordsNotMatchingError
                  ? 'Passwords don\'t match.'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CommonFormPadding(
          verticalPadding: 12,
          child: state.status.isSubmissionInProgress
              ? const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: state.status.isValidated && state.passwordConfirmed
                      ? () => context.read<SignUpFormCubit>().submit()
                      : null,
                  child: const Text(
                    'SIGN UP',
                  ),
                ),
        );
      },
    );
  }
}
