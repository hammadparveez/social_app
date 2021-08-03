import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/dynamic_link_model.dart';
import 'package:social_app/src/model/email_link_model.dart';

class LoginNotifier extends ChangeNotifier {
  final _emailLinkAuthModel = EmailLinkModelImpl(DynamicLinkGenerator());
  String isLoggedInKey = "isLoggedIn";
  bool _isLoggedIn = false;

  bool get isLoggedIn {
    final pref = GetIt.I.get<SharedPreferences>();
    _isLoggedIn = pref.getBool(isLoggedInKey) ?? false;

    return _isLoggedIn;
  }

  void login(String email) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isLoggedInKey) == null) {
      _isLoggedIn = await _emailLinkAuthModel.signInWithEmailLink(email);
      if (_isLoggedIn) prefs.setBool(isLoggedInKey, _isLoggedIn);
      log("LoggedIn: ${_isLoggedIn}");
    } else {
      log("Else");
      _isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;
    }

    notifyListeners();
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedOut = await _emailLinkAuthModel.signOut();
    if (isLoggedOut) {
      prefs.remove(isLoggedInKey);
      _isLoggedIn = !isLoggedOut;
    }
    notifyListeners();
  }
}
