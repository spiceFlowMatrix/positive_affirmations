import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/affirmations/blocs/affirmations/affirmations_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';
import 'package:mobile_app/affirmations/widgets/affirmations_list.dart';
import 'package:mobile_app/affirmations/widgets/app_navigator.dart';

class AffirmationsHomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

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
    return BlocProvider<AffirmationsBloc>(
      create: (context) {
        return new AffirmationsBloc();
      },
      child: BlocBuilder<ApptabBloc, AppTab>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state == AppTab.affirmations ? 'Affirmations' : 'Profile',
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
      ),
    );
  }
}
