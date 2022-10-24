import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/forgot_password/page/forgot_password_page.dart';
import 'package:hosy/screens/sign_in/bloc/signin_bloc.dart';
import 'package:hosy/screens/sign_in/widgets/sigin_content.dart';
import 'package:hosy/screens/sign_up/page/signup_page.dart';
import 'package:hosy/screens/tab_bar/page/tabbar_page.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<SignInBloc> _buildContext(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (BuildContext context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        buildWhen: (_, currState) => currState is SignInInitial,
        builder: (context, state) {
          return const SignInContent();
        },
        listenWhen: (_, currState) =>
            currState is NextForgotPasswordPageState ||
            currState is NextSignUpState ||
            currState is NextTabBarPageState ||
            currState is SignInErrorState,
        listener: (context, state) {
          if (state is NextForgotPasswordPageState) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
          } else if (state is NextSignUpState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const SignUpPage()));
          } else if (state is NextTabBarPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const TabBarPage()));
          } else if (state is SignInErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
