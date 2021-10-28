import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repository/repository.dart';

class ProfileLettersTab extends StatelessWidget {
  const ProfileLettersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _OptionsButton(),
        const Divider(
          height: 0,
          thickness: 1.5,
        ),
        Expanded(child: _List()),
      ],
    );
  }
}

class _OptionsButton extends StatelessWidget {
  String _generateTitleText(LetterCreationSchedule schedule) {
    switch (schedule) {
      case LetterCreationSchedule.daily:
        return 'Daily';
      case LetterCreationSchedule.weekly:
        return 'Weekly';
      case LetterCreationSchedule.monthly:
        return 'Monthly';
      case LetterCreationSchedule.never:
        return 'Never';
    }
  }

  List<ListTile> _generateScheduleOptions() {
    return LetterCreationSchedule.values.map((value) {
      return ListTile(
        title: Text(_generateTitleText(value)),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    const ListTile(
                      title: Text(
                        'Select a schedule',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(height: 0, thickness: 1.5),
                    ..._generateScheduleOptions(),
                  ],
                );
              },
            );
          },
          title: Text(
            _generateTitleText(state.user.letterSchedule),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text(
            'How often would you like me to check for letters?',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 15,
            color: Colors.black,
          ),
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text(
            'Letters',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
