import 'package:flutter/material.dart';

class CommonFormPadding extends StatelessWidget {
  const CommonFormPadding({
    Key? key,
    required this.child,
    this.verticalPadding = 12,
  }) : super(key: key);
  final Widget child;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: verticalPadding ?? 0,
      ),
      child: child,
    );
  }
}
