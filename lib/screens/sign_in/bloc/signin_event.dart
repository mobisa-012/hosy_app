part of'signin_bloc.dart';

@immutable
abstract class SignInEvent {}

class OnTextChangedEvent extends SignInEvent {}

class SignInTappedEvent extends SignInEvent {}

class ForgotPasswordTappedEvent extends SignInEvent {}

class SignUpTappedEvent extends SignInEvent {}