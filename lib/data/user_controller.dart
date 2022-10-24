import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/services/user.dart';

class UserController {
  static User getUser() {
    return User('Mobisa Kwamboka', '+254796116642', PathConstants.profile1);
  }
}
