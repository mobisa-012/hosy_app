part of'change_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class ChangePassword extends ChangePasswordEvent {
  final String newPassword;

  ChangePassword({
    required this.newPassword
  });
}