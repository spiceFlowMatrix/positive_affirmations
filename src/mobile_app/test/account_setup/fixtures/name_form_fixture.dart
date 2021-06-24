import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/name_form.dart';
import 'package:mobile_app/positive_affirmations_routes.dart';

class NameFormFixture extends StatelessWidget {
  NameFormFixture(this.bloc, {this.navigatorObserver});

  final SignUpBloc bloc;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: NameForm(),
        ),
        // initialRoute: NameFormScreen.routeName,
        routes: PositiveAffirmationsRoutes().routes(context),
        navigatorObservers: [if (navigatorObserver != null) navigatorObserver!],
      ),
    );
  }
}
