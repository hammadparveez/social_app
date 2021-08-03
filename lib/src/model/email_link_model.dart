import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/dynamic_link_model.dart';
import 'package:social_app/src/model/entites/email_link_entity.dart';
import 'package:social_app/src/model/model_constants.dart';

abstract class LoginModel {
  Future login(String email, [String password]);
  Future<bool> signOut();
}

abstract class EmailLinkModel {
  bool isSignInEmailLink(String emailLink);
  signInWithEmailLink(String email, String emailLink);
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
  Future<bool> signInWithEmailLink(String email, [String? emailLink]) async {
    final userExists = await _checkUserExists(email);
    log("User Exists: $userExists");
    if (userExists)
      isLoggedIn = true;
    else {
      await login(email);
      dynamicLinkGenerator.attachListenerOnLinkGenerate(
          (PendingDynamicLinkData? linkData) => _onSuccess(linkData, email),
          _onError);
    }
    return isLoggedIn;
  }

  //Creating User when Dynamic Link is successfully Linked
  Future<dynamic> _onSuccess(
      PendingDynamicLinkData? linkData, String email) async {
    isLoggedIn = false;
    final isValidLink = isSignInEmailLink("${linkData?.link.toString()}");
    if (isValidLink) {
      final credentials = await firebaseAuth.signInWithEmailLink(
          email: email, emailLink: linkData!.link.toString());
      final doc = await fireStore.collection(ModelString.usersCollection).add(
            EmailLinkEntity(credentials.user!.email!, credentials.user!.uid)
                .toMap(),
          );
      final snapshot = await doc.get();
      if (snapshot.exists) isLoggedIn = true;
      isLoggedIn = false;
    }
    throw Exception("Unable to create User");
  }

  Future<dynamic> _onError(OnLinkErrorException? error) async {
    log("Error With Dynamic Link");
  }

  Future<bool> _checkUserExists(String email) async {
    final query = fireStore
        .collection(ModelString.usersCollection)
        .where("email", isEqualTo: email);
    final docs = await query.get();
    log("Doc: ${docs.docs.isEmpty}}");
    if (docs.docs.isNotEmpty) {
      try {
        docs.docs.firstWhere((element) => element.data()["email"] == email);
        return true;
      } catch (e) {}
    }
    return false;
  }
}
