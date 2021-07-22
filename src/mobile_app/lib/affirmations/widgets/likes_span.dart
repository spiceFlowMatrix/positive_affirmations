import 'package:flutter/material.dart';
import 'package:repository/repository.dart';

class LikesSpan extends StatelessWidget {
  LikesSpan(
    this.affirmation, {
    required this.spanKey,
  });

  final Affirmation affirmation;
  final Key spanKey;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${affirmation.likes} likes',
      key: spanKey,
    );
  }
}
