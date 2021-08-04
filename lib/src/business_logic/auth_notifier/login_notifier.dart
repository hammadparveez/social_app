import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/di/service_locator.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/dynamic_link_model.dart';
import 'package:social_app/src/model/email_link_model.dart';
import 'package:social_app/src/model/entites/email_link_entity.dart';
import 'package:social_app/src/model/firebase_emailLink_auth_model.dart';

class LoginNotifier extends ChangeNotifier {
  final _emailLinkAuthModel = EmailLinkModelImpl(DynamicLinkGenerator());
  final _firebaseEmailLinkAuthModel = FirebaseEmailLinkAuthModelImpl();
  final _pref = getIt.get<SharedPreferences>();
  String _isLoggedInKey = "isLoggedIn";
  bool _isLoggedIn = false;
  EmailLinkEntity? _model;


  EmailLinkEntity? get model => _model;

  bool get isLoggedIn {
    _isLoggedIn = _pref.getBool(_isLoggedInKey) ?? false;
    return _isLoggedIn;
  }

  void login(String email) async {
    await _emailLinkAuthModel.login(email);
    await _emailLinkAuthModel.signInWithEmailLink(email, _onSuccess);
  }

  Future<dynamic> _onSuccess(PendingDynamicLinkData? linkData, email) async {
    _isLoggedIn = false;
    final isValidLink =
        _emailLinkAuthModel.isSignInEmailLink("${linkData?.link.toString()}");
    if (isValidLink) {
      _model = await _firebaseEmailLinkAuthModel
          .signInWithEmailLink<EmailLinkEntity>(linkData, email);
      log("onSuccess: ${_model?.email} and $_isLoggedIn");
      if (_model != null) {
        _isLoggedIn = true;
        _pref.setBool(_isLoggedInKey, _isLoggedIn);
      }
    } else
      log("Invalid Link");
    notifyListeners();
    //throw Exception("Invalid Dynamic Link");
  }


  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedOut = await _emailLinkAuthModel.signOut();
    if (isLoggedOut) {
      prefs.remove(_isLoggedInKey);
      _isLoggedIn = !isLoggedOut;
    }
    notifyListeners();
  }
}
