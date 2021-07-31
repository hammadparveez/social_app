import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/src/model/entites/user_entity.dart';
import 'package:social_app/src/model/model_constants.dart';

abstract class UserModel {
  final _fireBaseInstance = FirebaseFirestore.instance;

  Future createUsers(String userName, String email, String password);
}

class UserModelImpl extends UserModel {
  Future createUsers(String userName, String email, String password) async {
    final _collection =
        _fireBaseInstance.collection(FirebaseCollectionStrings.users);

    final documentRef = await _collection.add(
        UserEntity(userName: userName, email: email, password: password)
            .toMap());
    log("User has been Register ${documentRef.path} ");
  }
}
