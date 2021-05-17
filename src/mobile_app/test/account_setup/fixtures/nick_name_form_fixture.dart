import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form.dart';
import 'package:mobile_app/positive_affirmations_routes.dart';

class NickNameFormFixture extends StatelessWidget {
  NickNameFormFixture(this.bloc);

  final SignUpBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: NickNameForm(),
        ),
        // initialRoute: NameFormScreen.routeName,
        routes: PositiveAffirmationsRoutes().routes(context),
      ),
    );
  }
}
