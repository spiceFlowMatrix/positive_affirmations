import 'package:flutter/material.dart';

class NameFormScreen extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NameFormScreen());
  }

  // TODO: Write tests to check that keys are supplied
  // TODO: Add keys to components
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Hi. My name\'s Buddy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 23,
                  ),
                ),
                const Text(
                  'What\'s your name?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
