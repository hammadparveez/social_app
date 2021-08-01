import 'package:social_app/src/export.dart' show ChangeNotifier;
import 'package:social_app/src/model/user_model.dart';

abstract class RegisterNotifier extends ChangeNotifier {
  void registerUser(String userName, String email, String password);
}

class RegisterUserNotifier extends RegisterNotifier {
  UserModel _userModel;
  bool _hasRegistered = false;

  bool get hasRegistered => _hasRegistered;

  RegisterUserNotifier(UserModel userModel) : _userModel = userModel;

  @override
  Future<bool> registerUser(String userName, String email, String password) async {
    _hasRegistered = await _checkIfRegistered(userName, email, password);
    notifyListeners();
    return _hasRegistered;
  }

  Future<bool> _checkIfRegistered(
      String userName, String email, String password) async {
    try {
      final docRef = await _userModel.createUsers(userName, email, password);
      if (docRef != null) return true;
    } catch (e) {}
    return false;
  }
}
