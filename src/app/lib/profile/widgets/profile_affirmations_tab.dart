import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

class ProfileAffirmationsTab extends StatelessWidget {
  const ProfileAffirmationsTab({
    required Key key,
    required this.user,
  }) : super(key: key);
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AffirmationsBloc, AffirmationsState>(
      builder: (context, state) {
        if (state.loadingStatus == FormzStatus.submissionInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final toRenderAffirmations = state.affirmations
            .where((element) => element.createdById == user.id)
            .toList();
        return ListView.builder(
          itemCount: toRenderAffirmations.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  key: PositiveAffirmationsKeys.profileAffirmationItem(
                      toRenderAffirmations[index].id),
                  title: Text(
                    toRenderAffirmations[index].title,
                    key: PositiveAffirmationsKeys.profileAffirmationItemTitle(
                        toRenderAffirmations[index].id),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    final bloc = BlocProvider.of<AffirmationsBloc>(context);
                    Navigator.of(context).pushNamed(
                      AffirmationFormScreen.routeName,
                      arguments: AffirmationFormScreenArguments(
                        affirmationsBloc: bloc,
                        toUpdateAffirmation: toRenderAffirmations[index],
                      ),
                    );
                  },
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    key:
                    PositiveAffirmationsKeys.profileAffirmationItemTrailing(
                        toRenderAffirmations[index].id),
                    size: 15,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1.5,
                ),
              ],
            );
          },
        );
      },
    );
  }
}