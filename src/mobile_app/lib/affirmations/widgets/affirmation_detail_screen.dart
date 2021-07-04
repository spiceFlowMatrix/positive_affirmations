import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/widgets/likes_span.dart';
import 'package:mobile_app/models/affirmation.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class AffirmationDetailScreenArguments {
  const AffirmationDetailScreenArguments(this.affirmation);

  final Affirmation affirmation;
}

class AffirmationDetailScreen extends StatelessWidget {
  static const String routeName = '/affirmationDetailScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as AffirmationDetailScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Affirmation Details'),
        key: PositiveAffirmationsKeys.affirmationDetailsAppbarTitle,
        leading: IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          key: PositiveAffirmationsKeys.affirmationDetailsBackButton(
              '${args.affirmation.id}'),
        ),
        actions: [
          IconButton(
            key: PositiveAffirmationsKeys.affirmationDetailsAppbarEditButton(
                '${args.affirmation.id}'),
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.pen),
          ),
        ],
      ),
      body: _Body(args.affirmation),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.affirmation);

  final Affirmation affirmation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          Text(
            affirmation.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            key: PositiveAffirmationsKeys.affirmationDetailsTitle(
                '${affirmation.id}'),
          ),
          Text(
            affirmation.subtitle,
            style: TextStyle(),
            key: PositiveAffirmationsKeys.affirmationDetailsSubtitle(
                '${affirmation.id}'),
          ),
          LikesSpan(
            affirmation,
            spanKey: PositiveAffirmationsKeys.affirmationDetailsLikes(
                '${affirmation.id}'),
            likeButtonKey:
                PositiveAffirmationsKeys.affirmationDetailsLikeButton(
                    '${affirmation.id}'),
          ),
          Text(
            '${affirmation.totalReaffirmations} reaffirmations',
            key: PositiveAffirmationsKeys.affirmationDetailsReaffirmationsCount(
                '${affirmation.id}'),
          ),
          ElevatedButton(
            key: PositiveAffirmationsKeys.affirmationDetailsReaffirmButton(
                '${affirmation.id}'),
            onPressed: () {},
            child: Text('REAFFIRM'),
          ),
        ],
      ),
    );
  }
}
