import 'package:flutter/material.dart';

class AppSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AppSummary(),
    );
  }
}

class _AppSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('App summary screen'));
  }
}
