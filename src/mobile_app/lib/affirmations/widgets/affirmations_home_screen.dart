import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmations_list.dart';
import 'package:mobile_app/affirmations/widgets/app_navigator.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class AffirmationsHomeScreen extends StatelessWidget {
  const AffirmationsHomeScreen({this.affirmationsBloc});

  static const routeName = '/homeScreen';

  final AffirmationsBloc? affirmationsBloc;

  Widget _mapBody(AppTab tab) {
    switch (tab) {
      case AppTab.affirmations:
        return AffirmationsList();
      case AppTab.profile:
        return Center(
          child: Text('Profile Screen'),
        );
      default:
        return AffirmationsList();
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
              if (state == AppTab.affirmations)
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.plusSquare),
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
