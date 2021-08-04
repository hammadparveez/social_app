import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/src/model/model_constants.dart';

class TodoItemModel {
  final fireStore = FirebaseFirestore.instance;
  CollectionReference? _todoCollection;
  Future addToDoCollection(String email) async {
    final snapshot = await fireStore
        .collection(ModelString.usersCollection)
        .where("email", isEqualTo: email)
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      final el = snapshot.docs[i];
      _todoCollection = fireStore
          .collection(ModelString.usersCollection)
          .doc(el.id)
          .collection(ModelString.toDoCollection);
      break;
    }
  }

  Future addItem(String content) async {
    if (_todoCollection != null) {
      final docRef =
          await _todoCollection!.add({"content": content, "created": DateTime.now().millisecondsSinceEpoch});
      log("Item Added ${docRef}");
    }
  }
}
