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

  List<ListTile> _generateScheduleOptions(BuildContext context) {
    return LetterCreationSchedule.values.map((value) {
      return ListTile(
        title: Text(_generateTitleText(value)),
        onTap: () {
          context
              .read<ProfileBloc>()
              .add(LetterCreationScheduleUpdated(schedule: value));
          Navigator.of(context).pop();
        },
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
                    ..._generateScheduleOptions(context),
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
  final Widget _listHeader = const ListTile(
    title: Text(
      'Letters',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.letters.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _listHeader;
            } else {
              return _ListItem(
                letter: state.letters[index - 1],
              );
            }
          },
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.letter});

  final Letter letter;

  String _stringifyMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        letter.opened
            ? FontAwesomeIcons.envelopeOpen
            : FontAwesomeIcons.envelope,
        color: letter.opened ? Colors.grey : Colors.black,
      ),
      onTap: letter.opened ? null : () {},
      title: Text(
        '${letter.createdOn.day} ${_stringifyMonth(letter.createdOn.month)}, ${letter.createdOn.year}',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: letter.opened
          ? null
          : const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black,
              size: 18,
            ),
    );
  }
}
