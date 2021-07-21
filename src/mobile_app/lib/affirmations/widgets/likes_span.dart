import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:repository/repository.dart';

class LikesSpan extends StatelessWidget {
  LikesSpan(
    this.affirmation, {
    required this.spanKey,
    required this.likeButtonKey,
  });

  final Affirmation affirmation;
  final Key spanKey;
  final Key likeButtonKey;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: spanKey,
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
                key: likeButtonKey,
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
}
