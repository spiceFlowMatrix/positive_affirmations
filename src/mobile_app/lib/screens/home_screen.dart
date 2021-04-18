import 'package:flutter/material.dart';
import 'package:positive_affirmations/positive_affirmation_keys.dart';
import 'package:positive_affirmations/routes.dart';
import 'package:positive_affirmations/widgets/affirmations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positive Affirmations'),
      ),
      body: Center(
        child: Affirmations(),
      ),
      floatingActionButton: FloatingActionButton(
        key: PositiveAffirmationsKeys.addAffirmationFab,
        onPressed: () {
          Navigator.pushNamed(
              context, PositiveAffirmationsRoutes.addAffirmation);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
