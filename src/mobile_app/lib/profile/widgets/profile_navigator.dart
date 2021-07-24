import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/positive_affirmations_theme.dart';
import 'package:mobile_app/profile/blocs/profile/profile_bloc.dart';
import 'package:mobile_app/profile/blocs/profile_tab/profile_tab_bloc.dart';

class ProfileNavigator extends StatefulWidget {
  final ProfileTab activeTab;
  final Function(ProfileTab) onTabSelected;

  ProfileNavigator({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileNavigatorState(
      activeTab: activeTab, onTabSelected: onTabSelected);
}

class _ProfileNavigatorState extends State<ProfileNavigator>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final ProfileTab activeTab;
  final Function(ProfileTab) onTabSelected;

  _ProfileNavigatorState({
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _mapNavigationBarItem(ProfileTab tab, ProfileTab currentTab) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (tab) {
          case ProfileTab.affirmations:
            return Tab(
              key: PositiveAffirmationsKeys.profileAffirmationsSubtab(
                  '${state.user.id}'),
              child: Text(
                'Affirmations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: currentTab == ProfileTab.affirmations
                      ? PositiveAffirmationsTheme.highlightColor
                      : Colors.black,
                ),
              ),
            );
          case ProfileTab.letters:
            return Tab(
              key: PositiveAffirmationsKeys.profileLettersSubtab(
                  '${state.user.id}'),
              child: Text(
                'Letters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: currentTab == ProfileTab.letters
                      ? PositiveAffirmationsTheme.highlightColor
                      : Colors.black,
                ),
              ),
            );
          default:
            return Tab(
              icon: Text(
                'Affirmations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileTabBloc, ProfileTab>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        _tabController?.index = ProfileTab.values.indexOf(state);
        return Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
            color: Colors.grey.withOpacity(0.05),
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              onTabSelected(ProfileTab.values[index]);
            },
            isScrollable: false,
            tabs: ProfileTab.values.map((tab) {
              return _mapNavigationBarItem(tab, state);
            }).toList(),
          ),
        );
      },
    );
  }
}
