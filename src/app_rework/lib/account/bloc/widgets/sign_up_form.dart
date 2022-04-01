import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:positive_affirmations/account/bloc/sign_up_form/sign_up_form_cubit.dart';
import 'package:positive_affirmations/common/widgets/common_form_padding.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  static const String routeName = '/signUpForm';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpFormCubit>(
      create: (_) => SignUpFormCubit(),
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
          children: const [
            _NameField(),
            _NickNameField(),
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
