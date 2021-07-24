import 'package:flutter/material.dart';

class ProfileEditForm extends StatelessWidget {
  static const String routeName = '/profileEditForm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Profile edit form'),
      ),
    );
  }
}