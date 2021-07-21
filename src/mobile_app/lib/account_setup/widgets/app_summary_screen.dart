import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/account_setup/blocs/sign_up/sign_up_bloc.dart';
import 'package:mobile_app/blocs/authentication/authentication_bloc.dart';
import 'package:mobile_app/positive_affirmations_keys.dart';
import 'package:mobile_app/positive_affirmations_theme.dart';
import 'package:repository/repository.dart';

class AppSummaryScreenArguments {
  AppSummaryScreenArguments(this.bloc);

  final SignUpBloc bloc;
}

class AppSummaryScreen extends StatelessWidget {
  static const routeName = '/appSummaryScreen';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args =
        ModalRoute.of(context)!.settings.arguments as AppSummaryScreenArguments;

    return BlocProvider.value(
      value: args.bloc,
      child: Scaffold(
        key: PositiveAffirmationsKeys.appSummaryScreen,
        body: _AppSummary(),
      ),
    );
  }
}

class _AppSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        _ScreenControls(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _UserNameHeader(),
              Text(
                'Allow me to explain what I can do for you.',
                key: PositiveAffirmationsKeys.appSummaryHeader,
                textAlign: TextAlign.left,
                style: PositiveAffirmationsTheme.theme.textTheme.headline1
                    ?.copyWith(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'You can skip this at any time if you\'re getting bored though.',
                key: PositiveAffirmationsKeys.appSummarySubheader,
              ),
              Divider(
                thickness: 2,
              ),
              _AnimatedBody(
                key: PositiveAffirmationsKeys.appSummaryAnimatedBody,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScreenControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          leading: IconButton(
            key: PositiveAffirmationsKeys.changeNickNameButton,
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          trailing: TextButton(
            key: PositiveAffirmationsKeys.skipAppSummaryButton,
            onPressed: () {
              BlocProvider.of<SignUpBloc>(context).add(UserSubmitted());
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UserNameHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return RichText(
          key: PositiveAffirmationsKeys.appSummaryUserNameHeader,
          text: TextSpan(
            style:
                PositiveAffirmationsTheme.theme.textTheme.headline1?.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(text: 'Alright, '),
              TextSpan(
                text:
                    '${state.nickName.value.isNotEmpty ? state.nickName.value : state.name.value}',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 2,
                  decorationColor: PositiveAffirmationsTheme.highlightColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedBody extends StatefulWidget {
  _AnimatedBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedBodyState();
}

class _AnimatedBodyState extends State<_AnimatedBody> {
  final List<SequencedAnimatedTextItem> _buildQueue = [
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.cheerleaderBody,
      type: AnimatedTextItemType.title,
      text: 'I\'m your very own cheerleader',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.cheerleaderBody,
      type: AnimatedTextItemType.body,
      text: 'You can count on me to, well, cheer you on. Always.',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.awesomenessTitle,
      type: AnimatedTextItemType.title,
      text: 'I\'ll never forget how awesome you are!',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.awesomenessBody,
      type: AnimatedTextItemType.body,
      text:
          'And I know you forget so I\'ll keep on reminding you all the awesome things about you!',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.honestTitle,
      type: AnimatedTextItemType.title,
      text: 'I\'ll be honest with you',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.honestBody,
      type: AnimatedTextItemType.body,
      text:
          'For instance, I\'m not gonna pretend like I\'m not a machine. But one with a specific purpose - to help you love yourself!',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.spreadWordTitle,
      type: AnimatedTextItemType.title,
      text: 'I\'ll spread the word when you do something awesome',
    ),
    const SequencedAnimatedTextItem(
      key: PositiveAffirmationsKeys.spreadWordBody,
      type: AnimatedTextItemType.body,
      text:
          'Sometimes it won\'t be enough for a machine to shower you with good words. Sometimes, you just need a human touch. So I\'ll do what I can to get you those good words from other humans.\nIf you\'re self conscious, I\'ll make sure they don\'t know its you.',
    ),
  ];

  int _currentBuildIndex = 0;

  List<Widget> _body = [];

  AnimatedTextKit _buildTitleText(
    Key key,
    String text, {
    Function? onFinished,
  }) {
    return AnimatedTextKit(
      key: key,
      animatedTexts: [
        TyperAnimatedText(
          text,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
      displayFullTextOnTap: true,
      isRepeatingAnimation: false,
      onFinished: onFinished != null
          ? () {
              onFinished();
            }
          : () {},
    );
  }

  AnimatedTextKit _buildDescriptionText(
    Key key,
    String text, {
    Function? onFinished,
  }) {
    return AnimatedTextKit(
      key: key,
      animatedTexts: [
        TyperAnimatedText(
          text,
          textStyle: TextStyle(
            // fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
      onTap: () {},
      displayFullTextOnTap: true,
      isRepeatingAnimation: false,
      onFinished: onFinished != null
          ? () {
              onFinished();
            }
          : () {},
    );
  }

  void incrementBuild() {
    if (_currentBuildIndex <= _buildQueue.length - 1) {
      setState(() {
        switch (_buildQueue[_currentBuildIndex].type) {
          case AnimatedTextItemType.title:
            _body.add(
              _buildTitleText(
                _buildQueue[_currentBuildIndex].key,
                _buildQueue[_currentBuildIndex].text,
                onFinished: () {
                  incrementBuild();
                },
              ),
            );
            break;
          case AnimatedTextItemType.body:
            _body.add(
              _buildDescriptionText(
                _buildQueue[_currentBuildIndex].key,
                _buildQueue[_currentBuildIndex].text,
                onFinished: () {
                  incrementBuild();
                },
              ),
            );
            _body.add(const Padding(padding: EdgeInsets.only(top: 20)));
            break;
        }
        _currentBuildIndex++;
      });
    }
  }

  @override
  void initState() {
    _body.add(
      _buildTitleText(
        _buildQueue[_currentBuildIndex].key,
        _buildQueue[_currentBuildIndex].text,
        onFinished: () {
          incrementBuild();
        },
      ),
    );
    _currentBuildIndex++;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._body,
      ],
    );
  }
}

enum AnimatedTextItemType { title, body }

class SequencedAnimatedTextItem {
  const SequencedAnimatedTextItem({
    required this.key,
    required this.type,
    required this.text,
  });

  final Key key;
  final AnimatedTextItemType type;
  final String text;
}
