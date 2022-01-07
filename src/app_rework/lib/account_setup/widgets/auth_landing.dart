import 'package:flutter/material.dart';

class AuthLanding extends StatelessWidget {
  const AuthLanding({Key? key}) : super(key: key);

  static const String routeName = '/authLanding';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Auth Landing'),
      ),
    );
  }
}
