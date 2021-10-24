import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/consts.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:app/reaffirmation/widgets/reaffirmation_form_navigator.dart';
import 'package:repository/repository.dart';

class ReaffirmationFormScreenArguments extends Equatable {
  const ReaffirmationFormScreenArguments({
    this.reaffirmationBloc,
    required this.affirmationsBloc,
    required this.forAffirmation,
  });

  final ReaffirmationBloc? reaffirmationBloc;
  final AffirmationsBloc affirmationsBloc;
  final Affirmation forAffirmation;

  @override
  List<Object?> get props =>
      [reaffirmationBloc, affirmationsBloc, forAffirmation];
}

class ReaffirmationFormScreen extends StatelessWidget {
  static const String routeName = '/reaffirmationFormScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as ReaffirmationFormScreenArguments;
    final reaffirmationBloc = args.reaffirmationBloc ?? new ReaffirmationBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReaffirmationBloc>.value(value: reaffirmationBloc),
        BlocProvider<AffirmationsBloc>.value(value: args.affirmationsBloc),
      ],
      child: Scaffold(
        key: PositiveAffirmationsKeys.reaffirmationFormScreen,
        appBar: AppBar(
          title: Text(
            'Reaffirmation',
            key: PositiveAffirmationsKeys.reaffirmationFormScreenTitle,
          ),
          leading: IconButton(
            key: PositiveAffirmationsKeys.reaffirmationFormScreenBackButton,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
          ),
        ),
        body: _ScreenContent(forAffirmation: args.forAffirmation),
      ),
    );
  }
}

class _ScreenContent extends StatelessWidget {
  _ScreenContent({required this.forAffirmation});

  final Affirmation forAffirmation;

  Widget _mapBody() {
    return BlocBuilder<ReaffirmationBloc, ReaffirmationState>(
      builder: (context, state) {
        switch (state.tab) {
          case ReaffirmationFormTab.note:
            return _NotesMenu(currentValue: state.value.value);
          case ReaffirmationFormTab.font:
            return _FontsMenu(currentFont: state.font.value);
          case ReaffirmationFormTab.stamp:
            return _StampsMenu(currentStamp: state.stamp.value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaffirmationBloc, ReaffirmationState>(
      builder: (context, state) {
        return Column(
          children: [
            _PreviewPanel(
              affirmationId: this.forAffirmation.id,
              value: state.value.value,
              font: state.font.value,
              stamp: state.stamp.value,
            ),
            ReaffirmationFormNavigator(),
            Expanded(child: _mapBody()),
          ],
        );
      },
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  _PreviewPanel({
    required this.affirmationId,
    required this.value,
    required this.font,
    required this.stamp,
  });

  final String affirmationId;
  final ReaffirmationValue value;
  final ReaffirmationFont font;
  final ReaffirmationStamp stamp;

  bool get _canSubmit {
    if (value != ReaffirmationValue.empty && stamp != ReaffirmationStamp.empty)
      return true;
    return false;
  }

  Widget _buildSelectedValueLabel() {
    final value = PositiveAffirmationsConsts.reaffirmationNoteValue(this.value);
    final stamp = PositiveAffirmationsConsts.reaffirmationStampValue(this.stamp)
        .values
        .toList()[0];
    final font = PositiveAffirmationsConsts.reaffirmationFontValue(this.font);
    return Container(
      height: 40,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              key: PositiveAffirmationsKeys
                  .reaffirmationFormPreviewPanelSelectedNote,
              style: TextStyle(
                fontFamily: font,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              stamp,
              key: PositiveAffirmationsKeys
                  .reaffirmationFormPreviewPanelSelectedStamp,
              style: TextStyle(
                fontFamily: font,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    // return Text(
    //   '$value $stamp',
    //   style: TextStyle(
    //     fontFamily: font,
    //     fontSize: 30,
    //     fontWeight: FontWeight.bold,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: PositiveAffirmationsKeys.reaffirmationFormPreviewPanel,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(padding: EdgeInsets.only(top: 48)),
        Align(
          alignment: Alignment.center,
          child: _canSubmit
              ? _buildSelectedValueLabel()
              : Text(
                  PositiveAffirmationsConsts
                      .reaffirmationFormPreviewPanelEmptyLabel,
                  key: PositiveAffirmationsKeys
                      .reaffirmationFormPreviewPanelEmptyLabel,
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.6)),
                ),
        ),
        const Padding(padding: EdgeInsets.only(top: 40)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: ElevatedButton(
            key: PositiveAffirmationsKeys
                .reaffirmationFormPreviewPanelSubmitButton,
            onPressed: _canSubmit
                ? () {
                    BlocProvider.of<AffirmationsBloc>(context)
                        .add(ReaffirmationCreated(
                      affirmationId: affirmationId,
                      value: value,
                      font: font,
                      stamp: stamp,
                    ));
                    Navigator.of(context).pop();
                  }
                : null,
            child: Text(
              PositiveAffirmationsConsts
                  .reaffirmationFormPreviewPanelSubmitButtonValue,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 40)),
      ],
    );
  }
}

class _NotesMenu extends StatelessWidget {
  _NotesMenu({
    Key? key = PositiveAffirmationsKeys.reaffirmationFormNoteTabBody,
    required this.currentValue,
  }) : super(key: key);

  final ReaffirmationValue currentValue;

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    ReaffirmationValue.values.forEach((value) {
      items.add(ListTile(
        key: PositiveAffirmationsKeys.reaffirmationFormNoteTabBodyListItem(
            value.index),
        onTap: () {
          BlocProvider.of<ReaffirmationBloc>(context)
              .add(ValueSelected(value: value));
        },
        leading: Radio(
          value: value,
          groupValue: currentValue,
          onChanged: (val) {},
        ),
        title: Text(PositiveAffirmationsConsts.reaffirmationNoteValue(value)),
      ));
      items.add(const Divider(height: 1));
    });

    return ListView(
      key: PositiveAffirmationsKeys.reaffirmationFormNoteTabBodyList,
      children: items,
    );
  }
}

class _FontsMenu extends StatelessWidget {
  _FontsMenu({
    Key? key = PositiveAffirmationsKeys.reaffirmationFormFontTabBody,
    required this.currentFont,
  }) : super(key: key);

  final ReaffirmationFont currentFont;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItems = [];
    ReaffirmationFont.values.forEach((value) {
      listItems.add(
        ListTile(
          key: PositiveAffirmationsKeys.reaffirmationFormFontTabBodyListItem(
              value.index),
          onTap: () {
            BlocProvider.of<ReaffirmationBloc>(context)
                .add(FontSelected(font: value));
          },
          leading: Radio(
            value: value,
            groupValue: currentFont,
            onChanged: (val) {},
          ),
          title: Text(PositiveAffirmationsConsts.reaffirmationFontValue(value)),
        ),
      );
      listItems.add(const Divider(height: 1));
    });

    return ListView(
      key: PositiveAffirmationsKeys.reaffirmationFormFontTabBodyList,
      children: listItems,
    );
  }
}

class _StampsMenu extends StatelessWidget {
  _StampsMenu({
    Key? key = PositiveAffirmationsKeys.reaffirmationFormStampTabBody,
    required this.currentStamp,
  }) : super(key: key);

  final ReaffirmationStamp currentStamp;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItems = [];
    ReaffirmationStamp.values.forEach((value) {
      listItems.add(
        ListTile(
          key: PositiveAffirmationsKeys.reaffirmationFormStampTabBodyListItem(
              value.index),
          onTap: () {
            BlocProvider.of<ReaffirmationBloc>(context)
                .add(StampSelected(stamp: value));
          },
          leading: Radio(
            value: value,
            groupValue: currentStamp,
            onChanged: (val) {},
          ),
          title: Text(
              '${PositiveAffirmationsConsts.reaffirmationStampValue(value).keys.toList()[0]} ${PositiveAffirmationsConsts.reaffirmationStampValue(value).values.toList()[0]}'),
        ),
      );
      listItems.add(const Divider(height: 1));
    });

    return ListView(
      key: PositiveAffirmationsKeys.reaffirmationFormStampTabBodyList,
      children: listItems,
    );
  }
}
