import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:app/affirmations/widgets/likes_span.dart';
import 'package:app/consts.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:repository/repository.dart';

class AffirmationDetailScreenArguments {
  const AffirmationDetailScreenArguments(
    this.affirmation,
    this.affirmationsBloc,
  );

  final Affirmation affirmation;
  final AffirmationsBloc affirmationsBloc;
}

class AffirmationDetailScreen extends StatelessWidget {
  static const String routeName = '/affirmationDetailScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as AffirmationDetailScreenArguments;

    return BlocProvider<AffirmationsBloc>.value(
      value: args.affirmationsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Affirmation Details'),
          key: PositiveAffirmationsKeys.affirmationDetailsAppbarTitle,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
            key: PositiveAffirmationsKeys.affirmationDetailsBackButton(
                '${args.affirmation.id}'),
          ),
          actions: [
            IconButton(
              key: PositiveAffirmationsKeys.affirmationDetailsAppbarEditButton(
                  '${args.affirmation.id}'),
              onPressed: () {
                final bloc = args.affirmationsBloc;
                Navigator.of(context).pushNamed(
                  AffirmationFormScreen.routeName,
                  arguments: AffirmationFormScreenArguments(
                    affirmationsBloc: bloc,
                    toUpdateAffirmation: args.affirmation,
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.pen),
            ),
          ],
        ),
        body: _Body(args.affirmation),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body(this.affirmation);

  final Affirmation affirmation;

  final _underConstructionSnackbar = SnackBar(
    key: PositiveAffirmationsKeys.underConstructionSnackbar,
    content: Text(PositiveAffirmationsConsts.underConstructionSnackbarText),
  );

  Padding _buildPadding({
    Widget? child,
    double? top,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: top ?? 10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AffirmationsBloc, AffirmationsState>(
            builder: (context, state) {
              return Text(
                state.affirmations
                    .firstWhere((element) => element.id == affirmation.id)
                    .title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
                key: PositiveAffirmationsKeys.affirmationDetailsTitle(
                    '${affirmation.id}'),
              );
            },
          ),
          _buildPadding(
            child: BlocBuilder<AffirmationsBloc, AffirmationsState>(
              builder: (context, state) {
                return Text(
                  state.affirmations
                      .firstWhere((element) => element.id == affirmation.id)
                      .subtitle,
                  style: TextStyle(),
                  key: PositiveAffirmationsKeys.affirmationDetailsSubtitle(
                      '${affirmation.id}'),
                );
              },
            ),
          ),
          _buildPadding(
            child: BlocBuilder<AffirmationsBloc, AffirmationsState>(
              buildWhen: (previous, current) =>
                  previous.affirmations != current.affirmations,
              builder: (context, state) {
                return LikesSpan(
                  state.affirmations
                      .firstWhere((element) => element.id == affirmation.id),
                  spanKey: PositiveAffirmationsKeys.affirmationDetailsLikes(
                      '${affirmation.id}'),
                );
              },
            ),
          ),
          _buildPadding(
            child: Text(
              '${affirmation.totalReaffirmations} reaffirmations',
              key: PositiveAffirmationsKeys
                  .affirmationDetailsReaffirmationsCount('${affirmation.id}'),
            ),
          ),
          _buildPadding(
            child: ElevatedButton(
              key: PositiveAffirmationsKeys.affirmationDetailsReaffirmButton(
                  '${affirmation.id}'),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(_underConstructionSnackbar);
              },
              child: Text('REAFFIRM'),
            ),
            top: 20,
          ),
        ],
      ),
    );
  }
}
