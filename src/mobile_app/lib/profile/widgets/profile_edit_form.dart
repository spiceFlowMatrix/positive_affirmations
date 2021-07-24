import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/consts.dart';
import 'package:mobile_app/models/models.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:repository/repository.dart';

class ProfileEditFormArgs {
  const ProfileEditFormArgs({
    required this.profileBloc,
    this.profileEditBloc,
  });

  final ProfileBloc profileBloc;
  final ProfileEditBloc? profileEditBloc;
}

class ProfileEditForm extends StatelessWidget {
  static const String routeName = '/profileEditForm';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args =
        ModalRoute.of(context)!.settings.arguments as ProfileEditFormArgs;

    final profileEditBloc = args.profileEditBloc == null
        ? BlocProvider(
            create: (_) => ProfileEditBloc(
              profileBloc: args.profileBloc,
            ),
          )
        : BlocProvider<ProfileEditBloc>.value(value: args.profileEditBloc!);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(value: args.profileBloc),
        profileEditBloc,
      ],
      child: Scaffold(
        key: PositiveAffirmationsKeys.profileEditScreen,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            key: PositiveAffirmationsKeys.profileEditScreenTitle,
          ),
        ),
        body: _FormContent(userInitial: args.profileBloc.state.user),
      ),
    );
  }
}

class _FormContent extends StatelessWidget {
  _FormContent({required this.userInitial})
      : _nameController = TextEditingController(text: userInitial.name),
        _nickNameController = TextEditingController(text: userInitial.nickName),
        super(key: PositiveAffirmationsKeys.profileEditForm(userInitial.id));

  final GlobalKey<FormState> _editProfileFormKey = GlobalKey<FormState>();

  final User userInitial;

  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController;
  final TextEditingController _nickNameController;

  String _generateNameError(NameFieldValidationError error) {
    switch (error) {
      case NameFieldValidationError.empty:
        return PositiveAffirmationsConsts.nameFieldEmptyError;
      case NameFieldValidationError.invalid:
        return PositiveAffirmationsConsts.nameFieldInvalidError;
    }
  }

  String _generateNickNameError(NickNameFieldValidationError error) {
    switch (error) {
      case NickNameFieldValidationError.invalid:
        return PositiveAffirmationsConsts.nickNameFieldInvalidError;
    }
  }

  Widget _buildNameField() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return _FormField(
          fieldLabel: PositiveAffirmationsConsts.profileEditNameFieldLabel,
          fieldLabelKey: PositiveAffirmationsKeys.profileEditNameFieldLabel,
          fieldInputLabel: 'Name',
          fieldKey:
              PositiveAffirmationsKeys.profileEditNameField(userInitial.id),
          textEditingController: _nameController,
          focusNode: _nameFocusNode,
          textInputAction: TextInputAction.next,
          onChanged: (name) {
            BlocProvider.of<ProfileEditBloc>(context).add(NameUpdated(name));
          },
          errorText: state.name.error != null
              ? _generateNameError(state.name.error!)
              : null,
        );
      },
    );
  }

  Widget _buildNickNameField() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
      buildWhen: (previous, current) =>
          previous.nickName != current.nickName ||
          previous.status != current.status,
      builder: (context, state) {
        return _FormField(
          fieldLabel: PositiveAffirmationsConsts.profileEditNickNameFieldLabel,
          fieldLabelKey: PositiveAffirmationsKeys.profileEditNickNameFieldLabel,
          fieldInputLabel: 'Nickname',
          fieldKey:
              PositiveAffirmationsKeys.profileEditNickNameField(userInitial.id),
          textEditingController: _nickNameController,
          onChanged: (nickName) {
            BlocProvider.of<ProfileEditBloc>(context)
                .add(NickNameUpdated(nickName));
          },
          onSubmitted: (nickName) {
            if (state.status.isValid) {
              BlocProvider.of<ProfileEditBloc>(context)
                  .add(ProfileEditSubmitted());
            }
          },
          errorText: state.nickName.error != null
              ? _generateNickNameError(state.nickName.error!)
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _nameFocusNode.requestFocus();

    return BlocListener<ProfileEditBloc, ProfileEditState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Center(
        child: Form(
          key: _editProfileFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 35),
            shrinkWrap: true,
            children: [
              _buildNameField(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _buildNickNameField(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _SaveButton(user: userInitial),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  _FormField({
    required this.textEditingController,
    required this.fieldLabel,
    required this.fieldLabelKey,
    required this.fieldKey,
    required this.fieldInputLabel,
    required this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.errorText,
  });

  final String fieldLabel;
  final Key fieldLabelKey;
  final Key fieldKey;
  final String fieldInputLabel;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String value) onChanged;
  final Function(String value)? onSubmitted;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          fieldLabel,
          key: fieldLabelKey,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        TextField(
          key: fieldKey,
          controller: textEditingController,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            labelText: fieldInputLabel,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: PositiveAffirmationsKeys.profileEditSaveButton(user.id),
          onPressed: state.status.isValid
              ? () {
                  BlocProvider.of<ProfileEditBloc>(context)
                      .add(ProfileEditSubmitted());
                }
              : null,
          child: Text(
            'Save',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
