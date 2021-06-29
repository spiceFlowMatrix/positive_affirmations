import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/affirmations/blocs/apptab/apptab_bloc.dart';

class AppNavigator extends StatefulWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  AppNavigator({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppNavigatorState(activeTab: activeTab, onTabSelected: onTabSelected);
}

class _AppNavigatorState extends State<AppNavigator>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  _AppNavigatorState({
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Tab _mapNavigationBarItem(AppTab tab) {
    switch (tab) {
      case AppTab.affirmations:
        return Tab(
          icon: Text(
            'Affirmations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      case AppTab.profile:
        return Tab(
          icon: Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApptabBloc, AppTab>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        _tabController?.index = AppTab.values.indexOf(state);
        return TabBar(
          controller: _tabController,
          onTap: (index) {
            onTabSelected(AppTab.values[index]);
          },
          isScrollable: false,
          tabs: AppTab.values.map((tab) {
            return _mapNavigationBarItem(tab);
          }).toList(),
        );
      },
    );
  }
}
