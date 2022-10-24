import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/onboarding/widget/onboarding_content.dart';
import 'package:hosy/screens/sign_up/page/signup_page.dart';

import '../bloc/onboarding_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<OnboardingBloc> _buildContext(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (BuildContext context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (_, currState) => currState is NextScreenState,
        listener: (context, state) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return const SignUpPage();
          }));
        },
        builder: (context, state) {
          return const OnboardingContent();
        },
        buildWhen: (_, currState) => currState is OnboardingInitial,
      ),
    );
  }
}
