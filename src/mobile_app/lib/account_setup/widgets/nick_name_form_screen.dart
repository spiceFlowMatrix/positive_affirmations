import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/account_setup/widgets/nick_name_form.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';

class NickNameFormScreenArguments {
  NickNameFormScreenArguments(this.bloc);

  final SignUpBloc bloc;
}

class NickNameFormScreen extends StatelessWidget {
  // /// Can only route to this screen from nameForm and appSummary screens.
  // /// So makes sense to reuse the same bloc value instead of creating a new one.
  // const NickNameFormScreen(this.bloc);
  //
  // final SignUpBloc bloc;
  //
  // static Route route(SignUpBloc bloc) {
  //   return MaterialPageRoute<void>(builder: (_) => NickNameFormScreen(bloc));
  // }

  static const routeName = '/nickNameFormScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments
        as NickNameFormScreenArguments;

    return BlocProvider.value(
      value: args.bloc,
      child: Scaffold(
        key: PositiveAffirmationsKeys.nickNameFormScreen,
        body: NickNameForm(),
      ),
    );
  }
}
