import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmations_list.dart';
import 'package:mobile_app/affirmations/widgets/app_navigator.dart';
import 'package:mobile_app/affirmations/widgets/profile_details.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class AffirmationsHomeScreen extends StatelessWidget {
  const AffirmationsHomeScreen({this.affirmationsBloc});

  static const routeName = '/homeScreen';

  final AffirmationsBloc? affirmationsBloc;

  Widget _mapBody(AppTab tab) {
    switch (tab) {
      case AppTab.affirmations:
        return AffirmationsList(
          key: PositiveAffirmationsKeys.affirmationsList,
        );
      case AppTab.profile:
        return ProfileDetails(
          key: PositiveAffirmationsKeys.profileDetails,
        );
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
                    : FontAwesomeIcons.edit),
                key: state == AppTab.affirmations
                    ? PositiveAffirmationsKeys.affirmationsAppBarAddButton
                    : PositiveAffirmationsKeys.profileAppbarEditButton,
                onPressed: () {},
              )
            ],
          ),
          body: _mapBody(state),
          bottomNavigationBar: AppNavigator(
            activeTab: state,
            onTabSelected: (tab) =>
                BlocProvider.of<ApptabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );

    if (affirmationsBloc != null)
      return BlocProvider<AffirmationsBloc>.value(
        value: affirmationsBloc!,
        child: scaffold,
      );

    return BlocProvider<AffirmationsBloc>(
      create: (context) {
        return new AffirmationsBloc();
      },
      child: scaffold,
    );
  }
}
