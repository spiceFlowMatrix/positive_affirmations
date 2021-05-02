import 'package:flutter/material.dart';

class NameFormScreen extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NameFormScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
