import 'package:app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:app/affirmations/widgets/affirmation_form_screen.dart';
import 'package:app/affirmations/widgets/affirmations_list.dart';
import 'package:app/affirmations/widgets/app_navigator.dart';
import 'package:app/app_account/widgets/unverified_account_screen.dart';
import 'package:app/positive_affirmations_keys.dart';
import 'package:app/profile/blocs/profile/profile_bloc.dart';
import 'package:app/profile/widgets/profile_details_body.dart';
import 'package:app/profile/widgets/profile_options_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repository/repository.dart';

class AffirmationsHomeScreen extends StatelessWidget {
  const AffirmationsHomeScreen({
    this.affirmationsBloc,
    Key? key,
  }) : super(key: key);

  static const routeName = '/homeScreen';

  final AffirmationsBloc? affirmationsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.user.emailVerified) {
          return _Screen(affirmationsBloc: affirmationsBloc);
        } else {
          return const UnverifiedAccountScreen();
        }
      },
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen({required this.affirmationsBloc});

  final AffirmationsBloc? affirmationsBloc;

  Widget _mapBody(BuildContext context, AppTab tab) {
    switch (tab) {
      case AppTab.affirmations:
        context.read<AffirmationsBloc>().add(const AffirmationsLoaded());
        return AffirmationsList(
          key: PositiveAffirmationsKeys.affirmationsList,
        );
      case AppTab.profile:
        return const ProfileDetailsTabBody();
      default:
        return AffirmationsList(
          key: PositiveAffirmationsKeys.affirmationsList,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = BlocBuilder<ApptabBloc, AppTab>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state == AppTab.affirmations ? 'Affirmations' : 'Profile',
              key: state == AppTab.affirmations
                  ? PositiveAffirmationsKeys.affirmationsAppbarTitle
                  : PositiveAffirmationsKeys.profileAppbarTitle,
            ),
            actions: [
              IconButton(
                icon: FaIcon(state == AppTab.affirmations
                    ? FontAwesomeIcons.plusSquare
                    : FontAwesomeIcons.cog),
                key: state == AppTab.affirmations
                    ? PositiveAffirmationsKeys.affirmationsAppBarAddButton
                    : PositiveAffirmationsKeys.profileAppbarEditButton,
                onPressed: () {
                  switch (state) {
                    case AppTab.affirmations:
                      final bloc = BlocProvider.of<AffirmationsBloc>(context);
                      Navigator.of(context).pushNamed(
                        AffirmationFormScreen.routeName,
                        arguments: AffirmationFormScreenArguments(
                            affirmationsBloc: bloc),
                      );
                      break;
                    case AppTab.profile:
                      Navigator.of(context).pushNamed(
                        ProfileOptionsScreen.routeName,
                      );
                      break;
                  }
                },
              )
            ],
          ),
          body: _mapBody(context, state),
          bottomNavigationBar: AppNavigator(
            activeTab: state,
            onTabSelected: (tab) =>
                BlocProvider.of<ApptabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );

    if (affirmationsBloc != null) {
      return BlocProvider<AffirmationsBloc>.value(
        value: affirmationsBloc!,
        child: scaffold,
      );
    }

    // final authUser = context.read<ProfileBloc>().state.user;

    return BlocProvider<AffirmationsBloc>(
      create: (context) {
        return AffirmationsBloc(
          userRepository: context.read<UserRepository>(),
          affirmationsRepository: context.read<AffirmationsRepository>(),
        );
      },
      child: scaffold,
    );
  }
}
