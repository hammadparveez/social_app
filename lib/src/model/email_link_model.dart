import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/model_constants.dart';

abstract class LoginModel {
  Future login(String email, [String password]);
}

class EmailLinkAuthModel extends LoginModel {
  final firebaseDynamic = FirebaseDynamicLinks.instance;
  final firebaseAuth = FirebaseAuth.instance;

  void createDynamicLink() {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: ModelString.dynamicLinkHTTPS,
      link: Uri.parse(ModelString.baseUri),
      androidParameters: AndroidParameters(
        packageName: ModelString.pkgName,
        minimumVersion: ModelString.dynamicAndroidVersion,
      ),
      iosParameters: IosParameters(
        bundleId: ModelString.pkgName,
        minimumVersion: '${ModelString.dynamicAppleVersion}',
        appStoreId: '123',
      ),
    );
    _shortenDynamicLink(parameters);
  }

  bool isEmailSignInLink(String emailLink) {
    final isLoginAble = firebaseAuth.isSignInWithEmailLink(emailLink);
    if (isLoginAble) return true;
    return false;
  }

  Future<Uri> _shortenDynamicLink(DynamicLinkParameters parameters) async {
    var dynamicUrl = await parameters.buildShortLink();
    final shortUrl = dynamicUrl.shortUrl;
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    return shortUrl;
  }

  void attachListenerOnLinkGenerate(
      Future<dynamic> Function(PendingDynamicLinkData?) onSuccess,
      Future<dynamic> Function(OnLinkErrorException?) onError) {
    firebaseDynamic.onLink(onSuccess: onSuccess, onError: onError);
  }

  @override
  Future login(String email, [String? password]) async {
    final auth = FirebaseAuth.instance;

    final actionCodes = ActionCodeSettings(
        url: ModelString.baseUri,
        handleCodeInApp: true,
        androidPackageName: ModelString.pkgName);
    try {
      await auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodes);
    } catch (e) {
      log("Error ${e}");
    }
  }
}
