import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmation_form/affirmation_form_bloc.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/models/affirmation.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class AffirmationFormScreenArguments {
  AffirmationFormScreenArguments({
    required this.affirmationsBloc,
    this.affirmationFormBloc,
    this.toUpdateAffirmation,
  });

  final AffirmationsBloc affirmationsBloc;
  final AffirmationFormBloc? affirmationFormBloc;
  final Affirmation? toUpdateAffirmation;
}

class AffirmationFormScreen extends StatelessWidget {
  static const String routeName = '/affirmationFormScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as AffirmationFormScreenArguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AffirmationsBloc>.value(value: args.affirmationsBloc),
        if (args.affirmationFormBloc != null)
          BlocProvider<AffirmationFormBloc>.value(
              value: args.affirmationFormBloc!)
        else
          BlocProvider<AffirmationFormBloc>(
              create: (_) => new AffirmationFormBloc(
                  affirmationsBloc: args.affirmationsBloc))
      ],
      child: Scaffold(
        key: PositiveAffirmationsKeys.affirmationForm,
        appBar: AppBar(
          key: args.toUpdateAffirmation != null
              ? PositiveAffirmationsKeys.editAffirmationFormAppbarTitle
              : PositiveAffirmationsKeys.newAffirmationFormAppbarTitle,
          title: args.toUpdateAffirmation != null
              ? Text('Edit Affirmation')
              : Text('New Affirmation'),
          leading: IconButton(
            key: PositiveAffirmationsKeys.affirmationFormBackButton,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
          ),
        ),
        body: _AffirmationForm(args.toUpdateAffirmation),
      ),
    );
  }
}

class _AffirmationForm extends StatelessWidget {
  _AffirmationForm(this.toUpdateAffirmation);

  final GlobalKey<FormState> _affirmationFormKey = GlobalKey<FormState>();

  final Affirmation? toUpdateAffirmation;

  Widget _buildTitleLabel() {
    return Text(
      'Tell me something awesome about you',
      key: PositiveAffirmationsKeys.affirmationFormTitleFieldLabel,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSubtitleLabel() {
    return Text(
      'I\'d love it if you told me more about that',
      key: PositiveAffirmationsKeys.affirmationFormSubtitleFieldLabel,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: _affirmationFormKey,
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildTitleLabel(),
              const Padding(padding: EdgeInsets.only(top: 15)),
              _TitleField(),
              const Padding(padding: EdgeInsets.only(top: 30)),
              _buildSubtitleLabel(),
              const Padding(padding: EdgeInsets.only(top: 15)),
              _SubtitleField(),
              const Padding(padding: EdgeInsets.only(top: 30)),
              _SaveButton(),
              if (toUpdateAffirmation != null) ...[
                const Padding(padding: EdgeInsets.only(top: 30)),
                _ActivateDeactivateButton(toUpdateAffirmation!.id),
                const Padding(padding: EdgeInsets.only(top: 30)),
                _DeleteButton(toUpdateAffirmation!.id),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: PositiveAffirmationsKeys.affirmationFormTitleField,
      onChanged: (title) {},
      decoration: InputDecoration(
        labelText: 'Title',
      ),
    );
  }
}

class _SubtitleField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: PositiveAffirmationsKeys.affirmationFormSubtitleField,
      onChanged: (title) {},
      decoration: InputDecoration(
        labelText: 'Description',
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: PositiveAffirmationsKeys.affirmationFormSaveButton,
      onPressed: () {},
      child: Text('SAVE'),
    );
  }
}

class _ActivateDeactivateButton extends StatelessWidget {
  _ActivateDeactivateButton(this.id);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: PositiveAffirmationsKeys.affirmationFormDeactivateDeactivateButton(
          '$id'),
      onPressed: () {},
      child: Text('DEACTIVATE'),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  _DeleteButton(this.id);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: PositiveAffirmationsKeys.affirmationFormDeleteButton('$id'),
      onPressed: () {},
      child: Text('DELETE'),
    );
  }
}
