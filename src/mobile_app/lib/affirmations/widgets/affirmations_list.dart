import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/models/affirmation.dart';

class AffirmationsList extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 8,
      title: Text(
        affirmation.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(affirmation.subtitle),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: FaIcon(
                      FontAwesomeIcons.heart,
                      size: 18,
                    ),
                  ),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(text: '${affirmation.likes} likes'),
              ],
            ),
          ),
          Text(
            '${affirmation.totalReaffirmations} reaffirmations...',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
