import 'dart:developer';

import 'package:social_app/src/export.dart' show ChangeNotifier;
import 'package:social_app/src/model/user_model.dart';

abstract class RegisterNotifier extends ChangeNotifier {
  void registerUser(String userName, String email, String password);
}

class RegisterUserNotifier extends RegisterNotifier {
  UserModel _userModel;
  RegisterUserNotifier(UserModel userModel) : _userModel = userModel;

  @override
  void registerUser(String userName, String email, String password) async {
    await _userModel.createUsers(userName, email, password);
    log("Notifier");
    notifyListeners();
  }
}
