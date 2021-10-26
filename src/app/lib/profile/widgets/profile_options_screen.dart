import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:app/profile/widgets/profile_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        _EditProfileButton(),
        const Divider(height: 0, thickness: 1.5),
        _LogOutButton(),
        const Divider(height: 0, thickness: 1.5),
      ],
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Log out',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
      onTap: () {
        context.read<ProfileBloc>().add(LoggedOut());
      },
      // trailing: const FaIcon(
      //   FontAwesomeIcons.chevronRight,
      //   size: 15,
      //   color: Colors.black,
      // ),
    );
  }
}
