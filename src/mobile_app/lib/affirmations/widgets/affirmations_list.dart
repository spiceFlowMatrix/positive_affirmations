import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/models/affirmation.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class AffirmationsList extends StatelessWidget {
  AffirmationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _List();
  }
}

class _List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AffirmationsBloc, AffirmationsState>(
      builder: (context, state) {
        if (state.affirmations.isEmpty) {
          return _CallToAction();
        }
        return ListView.builder(
          itemCount: state.affirmations.length,
          itemBuilder: (context, index) => _ListItem(
            state.affirmations[index],
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem(this.affirmation);

  final Affirmation affirmation;

  static const Padding _subtitlePadding =
      const Padding(padding: EdgeInsets.only(top: 10));

  RichText _buildLikes(BuildContext context) {
    return RichText(
      key: PositiveAffirmationsKeys.affirmationItemLikes('${affirmation.id}'),
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        children: [
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                key: PositiveAffirmationsKeys.affirmationItemLikeButton(
                    '${affirmation.id}'),
                onTap: () => BlocProvider.of<AffirmationsBloc>(context)
                    .add(AffirmationLiked(affirmation.id)),
                child: FaIcon(
                  affirmation.liked
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  size: 18,
                  color: affirmation.liked ? Colors.red : Colors.black,
                ),
              ),
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          TextSpan(
            text: '${affirmation.likes} likes',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: PositiveAffirmationsKeys.affirmationItem('${affirmation.id}'),
      onTap: () {},
      minVerticalPadding: 20,
      title: Text(
        affirmation.title,
        key: PositiveAffirmationsKeys.affirmationItemTitle('${affirmation.id}'),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _subtitlePadding,
          Text(
            affirmation.subtitle,
            key: PositiveAffirmationsKeys.affirmationItemSubtitle(
                '${affirmation.id}'),
          ),
          _subtitlePadding,
          _buildLikes(context),
          _subtitlePadding,
          Text(
            '${affirmation.totalReaffirmations} reaffirmations...',
            key: PositiveAffirmationsKeys.affirmationItemReaffirmationsCount(
                '${affirmation.id}'),
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class _CallToAction extends StatelessWidget {
  Padding _buildVerticalPadding() {
    return Padding(padding: EdgeInsets.only(top: 15));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        key: PositiveAffirmationsKeys.noAffirmationsWarningBody,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.heartBroken,
              key: PositiveAffirmationsKeys.noAffirmationsWarningIcon,
              color: Colors.red.withOpacity(0.5),
              size: 86,
            ),
          ),
          _buildVerticalPadding(),
          Text(
            'Nothing here yet 😧',
            key: PositiveAffirmationsKeys.noAffirmationsWarningLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.black.withOpacity(0.82),
            ),
          ),
          _buildVerticalPadding(),
          ElevatedButton(
            onPressed: () {},
            child: Text('ADD'),
            key: PositiveAffirmationsKeys.noAffirmationsWarningButton,
          ),
        ],
      ),
    );
  }
}
