part of 'edit_bloc.dart';

@immutable
abstract class EditAccountEvent {}

class UploadImage extends EditAccountEvent {}

class ChangeUserDate extends EditAccountEvent {
  final String displayName;
  final String email;

  ChangeUserDate({
    required this.displayName,
    required this.email
  });
  }
