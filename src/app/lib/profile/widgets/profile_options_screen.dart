import 'package:app/profile/widgets/profile_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileOptionsScreen extends StatelessWidget {
  const ProfileOptionsScreen({Key? key}) : super(key: key);

  static const String routeName = '/profileOptionsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Options'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: _OptsList(),
    );
  }
}

class _OptsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            'Edit profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              ProfileEditForm.routeName,
              arguments: const ProfileEditFormArgs(),
            );
          },
          trailing: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 15,
            color: Colors.black,
          ),
        ),
        const Divider(height: 0, thickness: 1.5),
      ],
    );
  }
}
