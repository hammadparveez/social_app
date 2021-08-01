import 'dart:developer';

import 'package:social_app/src/export.dart';

abstract class LoginModel {
  Future login(String email, [String password]);
}

class EmailLinkAuthModel extends LoginModel {
  @override
  Future login(String email, [String? password]) async {
    final auth = FirebaseAuth.instance;

    final actionCodes = ActionCodeSettings(
        url: "https://www.exclusiveinn.com",
        handleCodeInApp: true,
        androidPackageName: 'com.example.social_app');
    try {
      await auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodes);
    } catch (e) {
      log("Error ${e}");
    }
  }
}
