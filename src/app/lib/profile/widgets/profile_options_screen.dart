import 'package:flutter/material.dart';

class ProfileOptionsScreen extends StatelessWidget {
  const ProfileOptionsScreen({Key? key}) : super(key: key);

  static const String routeName = '/profileOptionsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Options'),
      ),
      body: const Center(
        child: Text('Account Options Screen'),
      ),
    );
  }
}
