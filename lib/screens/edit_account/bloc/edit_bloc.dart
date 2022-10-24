import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hosy/core/services/firebase_storage_services.dart';
import 'package:hosy/core/services/user_service.dart';
import 'package:image_picker/image_picker.dart';


part 'edit_state.dart';
part 'edit_event.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountInitial());

  Stream<EditAccountState> mapEventToState(EditAccountEvent event) async* {
    if (event is UploadImage) {
      try {
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          yield EditAccountProgress();
          await FirebaseStorageService.uploadImage(filePath: image.path);
          yield EditPhotoSuccess(image);
        }
      } catch (e) {
        yield EditAccountError(error: e.toString());
        await Future.delayed(const Duration(seconds: 1));
        yield EditAccountInitial();
      }
    }
    if (event is ChangeUserDate) {
      yield EditAccountProgress();
      try {
        await UserService.changeUserData(
            displayName: event.displayName, email: event.email);
        yield EditAccountInitial();
      } catch (e) {
        yield EditAccountError(error: e.toString());
        await Future.delayed(const Duration(seconds: 1));
        yield EditAccountInitial();
      }
    }
  }
}
