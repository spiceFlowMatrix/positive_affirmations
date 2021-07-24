import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/consts.dart';
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
      : super(key: PositiveAffirmationsKeys.profileEditForm(userInitial.id));

  final GlobalKey<FormState> _editProfileFormKey = GlobalKey<FormState>();

  final User userInitial;

  final FocusNode _nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _nameFocusNode.requestFocus();

    return Center(
      child: Form(
        key: _editProfileFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 35),
          shrinkWrap: true,
          children: [
            _FormField(
              fieldLabel: PositiveAffirmationsConsts.profileEditNameFieldLabel,
              fieldLabelKey: PositiveAffirmationsKeys.profileEditNameFieldLabel,
              fieldInputLabel: 'Name',
              fieldKey:
                  PositiveAffirmationsKeys.profileEditNameField(userInitial.id),
              initialName: userInitial.name,
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            _FormField(
              fieldLabel:
                  PositiveAffirmationsConsts.profileEditNickNameFieldLabel,
              fieldLabelKey:
                  PositiveAffirmationsKeys.profileEditNickNameFieldLabel,
              fieldInputLabel: 'Nickname',
              fieldKey: PositiveAffirmationsKeys.profileEditNickNameField(
                  userInitial.id),
              initialName: userInitial.nickName,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  _FormField({
    required this.fieldLabel,
    required this.fieldLabelKey,
    required this.fieldKey,
    required this.fieldInputLabel,
    required this.initialName,
    this.focusNode,
    this.textInputAction,
  }) : _textEditingController = TextEditingController(text: initialName);

  final String fieldLabel;
  final Key fieldLabelKey;
  final Key fieldKey;
  final String fieldInputLabel;
  final String initialName;
  final TextEditingController _textEditingController;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

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
          controller: _textEditingController,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: fieldInputLabel,
          ),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
