import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/sign_in/page/signin_page.dart';
import 'package:hosy/screens/sign_up/bloc/signup_bloc.dart';
import 'package:hosy/screens/sign_up/widgets/signup_content.dart';
import 'package:hosy/screens/tab_bar/page/tabbar_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SignUpBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (_, currState) =>
            currState is NextTabBarPageState ||
            currState is NextSignInPageState ||
            currState is ErrorState,
        listener: (context, state) {
          if (state is NextTabBarPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const TabBarPage()));
          }
          if (state is NextSignInPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SignInPage()));
          }
          if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        buildWhen: (_, currState) => currState is SignUpInitial,
        builder: (context, state) {
          return const SignUpContent();
        },
      ),
    );
  }
}
