// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/core/services/auth_service.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial());

  final emailController = TextEditingController();
  bool isError = false;

  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordTappedEvent) {
      try {
        yield ForgotPasswordLoading();
        await AuthService.resetPassword(emailController.text);
        yield ForgotPasswordSuccess();
      } catch (e) {
        print('Error: $e');
        yield ForgotPasswordError(message: e.toString());
      }
    }
  }
}
