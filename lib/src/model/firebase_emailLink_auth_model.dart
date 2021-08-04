import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/entites/email_link_entity.dart';
import 'package:social_app/src/model/model_constants.dart';

abstract class FirebaseEmailLinkAuthModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<T?> signInWithEmailLink<T>(PendingDynamicLinkData? linkData, email);
}

class FirebaseEmailLinkAuthModelImpl extends FirebaseEmailLinkAuthModel {
  final fireStore = FirebaseFirestore.instance;
  @override
  Future<T?> signInWithEmailLink<T>(
      PendingDynamicLinkData? linkData, email) async {
    final credentials = await auth.signInWithEmailLink(
        email: email, emailLink: linkData!.link.toString());
    final model = await _checkUserExists<T>("${credentials.user?.email}");
    if (model == null) {
      final user =
          await _addUser(credentials.user!.email!, credentials.user!.uid) as T;
      return user;
    }
    log("Model error");
    return model;
  }

  Future<EmailLinkEntity?> _addUser(String email, String uid) async {
    final doc = await fireStore.collection(ModelString.usersCollection).add(
          EmailLinkEntity(email, uid).toMap(),
        );
    final snapshot = await doc.get();
    if (snapshot.exists) return EmailLinkEntity.toJson(snapshot.data()!);
    return null;
  }

  Future<T?> _checkUserExists<T>(String email) async {
    final query = fireStore
        .collection(ModelString.usersCollection)
        .where("email", isEqualTo: email);
    final docs = await query.get();
    log("Doc: ${docs.docs.isEmpty}}");
    if (docs.docs.isNotEmpty) {
      try {
        final doc =
            docs.docs.firstWhere((element) => element.data()["email"] == email);
        return EmailLinkEntity.toJson(doc.data()) as T;
      } catch (e) {}
    }
    return null;
  }
}
