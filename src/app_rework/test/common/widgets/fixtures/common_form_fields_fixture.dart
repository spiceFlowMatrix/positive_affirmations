import 'package:flutter/material.dart';
import 'package:positive_affirmations/theme.dart';

class CommonFormFieldsFixture extends StatelessWidget {
  const CommonFormFieldsFixture({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(
        body: Column(
          children: children,
        ),
      ),
    );
  }
}
