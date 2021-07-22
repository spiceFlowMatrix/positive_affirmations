import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_detail_screen.dart';
import 'package:mobile_app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:mobile_app/affirmations/widgets/likes_span.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/positive_affirmations_theme.dart';
import 'package:repository/repository.dart';

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
          return _NoAffirmationsWarning();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: ListTile(
        key: PositiveAffirmationsKeys.affirmationItem('${affirmation.id}'),
        // onTap: () {
        //   final bloc = BlocProvider.of<AffirmationsBloc>(context);
        //   Navigator.of(context).pushNamed(
        //     AffirmationDetailScreen.routeName,
        //     arguments: AffirmationDetailScreenArguments(affirmation, bloc),
        //   );
        // },
        minVerticalPadding: 20,
        title: Text(
          affirmation.title,
          key: PositiveAffirmationsKeys.affirmationItemTitle(
              '${affirmation.id}'),
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
            LikesSpan(
              affirmation,
              spanKey: PositiveAffirmationsKeys.affirmationItemLikes(
                  '${affirmation.id}'),
            ),
            _subtitlePadding,
            Text(
              '${affirmation.totalReaffirmations} reaffirmations...',
              key: PositiveAffirmationsKeys.affirmationItemReaffirmationsCount(
                  '${affirmation.id}'),
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            _subtitlePadding,
            _LikeButton(affirmation: affirmation),
            _ReaffirmButton(affirmation),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton({required this.affirmation});

  final Affirmation affirmation;

  @override
  Widget build(BuildContext context) {
    // Reference for working border solution https://flutteragency.com/how-to-listview-with-separator-in-flutter/
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: new BoxDecoration(
          border: new Border(
            top: new BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
        ),
        child: ListTile(
          key: PositiveAffirmationsKeys.affirmationItemLikeButton(
              '${affirmation.id}'),
          onTap: () {
            BlocProvider.of<AffirmationsBloc>(context)
                .add(AffirmationLiked(affirmation.id));
          },
          title: Text(
            'LIKE',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: FaIcon(FontAwesomeIcons.chevronRight),
          // Reference for working solution https://www.codesansar.com/flutter/circle-avatar-border.htm
          leading: CircleAvatar(
            radius: 17,
            backgroundColor: affirmation.liked
                ? Colors.red.withOpacity(0.1)
                : Colors.red.withOpacity(0.5),
            child: CircleAvatar(
              radius: 15,
              backgroundColor:
                  affirmation.liked ? Colors.transparent : Colors.white,
              child: FaIcon(
                affirmation.liked
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: Colors.red,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReaffirmButton extends StatelessWidget {
  const _ReaffirmButton(this.affirmation);

  final Affirmation affirmation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: new BoxDecoration(
          border: new Border(
            // bottom: new BorderSide(color: Colors.grey.withOpacity(0.5)),
            top: new BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
        ),
        child: ListTile(
          key: PositiveAffirmationsKeys.affirmationItemReaffirmButton(
              '${affirmation.id}'),
          onTap: () {},
          title: Text(
            'REAFFIRM',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: FaIcon(FontAwesomeIcons.chevronRight),
          // Reference for working solution https://www.codesansar.com/flutter/circle-avatar-border.htm
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FaIcon(
              FontAwesomeIcons.solidThumbsUp,
              color: PositiveAffirmationsTheme.highlightColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _NoAffirmationsWarning extends StatelessWidget {
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
            onPressed: () {
              final bloc = BlocProvider.of<AffirmationsBloc>(context);
              Navigator.of(context).pushNamed(
                AffirmationFormScreen.routeName,
                arguments:
                    AffirmationFormScreenArguments(affirmationsBloc: bloc),
              );
            },
            child: Text('LETS GET STARTED'),
            key: PositiveAffirmationsKeys.noAffirmationsWarningButton,
          ),
        ],
      ),
    );
  }
}
