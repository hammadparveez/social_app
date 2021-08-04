import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/dynamic_link_model.dart';
import 'package:social_app/src/model/model_constants.dart';

typedef OnEmailLinkSuccessCallBack = Future<dynamic> Function(
    PendingDynamicLinkData?, String email);

//
abstract class LoginModel {
  Future login(String email, [String password]);
  Future<bool> signOut();
}

abstract class EmailLinkModel {
  bool isSignInEmailLink(String emailLink);
  signInWithEmailLink(String email, OnEmailLinkSuccessCallBack success);
}

class EmailLinkModelImpl implements EmailLinkModel, LoginModel {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final DynamicLinkGenerator dynamicLinkGenerator;
  bool isLoggedIn = false;
  EmailLinkModelImpl(this.dynamicLinkGenerator);

  @override
  Future login(String email, [String? password]) async {
    final actionCodes = ActionCodeSettings(
        url: ModelString.baseUri,
        handleCodeInApp: true,
        androidPackageName: ModelString.pkgName);
    try {
      await firebaseAuth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodes);
    } catch (e) {
      log("Error ${e}");
    }
  }

  @override
  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    if (firebaseAuth.currentUser == null) return true;
    return false;
  }

  @override
  bool isSignInEmailLink(String emailLink) {
    return firebaseAuth.isSignInWithEmailLink(emailLink);
  }

  @override
  Future signInWithEmailLink(
      String email, OnEmailLinkSuccessCallBack success) async {
    dynamicLinkGenerator.attachListenerOnLinkGenerate(
        (PendingDynamicLinkData? linkData) => success(linkData, email),
        _onError);
  }

  Future<dynamic> _onError(OnLinkErrorException? error) async {
    log("Error With Dynamic Link");
  }
}
