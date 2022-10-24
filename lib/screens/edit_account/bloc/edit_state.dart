part of 'edit_bloc.dart';

@immutable
abstract class EditAccountState {}

class EditAccountInitial extends EditAccountState {}

class EditAccountProgress extends EditAccountState {}

class EditPhotoSuccess extends EditAccountState {
  final XFile image;

  EditPhotoSuccess( this.image);
}

class EditAccountError extends EditAccountState {
  final String error;

  EditAccountError({
    required this.error
  });
}
