import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/src/model/entites/todo_entity.dart';
import 'package:social_app/src/model/firebase_models.dart';
import 'package:social_app/src/model/model_constants.dart';

class TodoItemModel {
  final fireStore = FirebaseFirestore.instance;
  GetCollectionFirebase _todoCollectionFirebase = GetTodoCollectionFirebase();

  CollectionReference? _todoCollection;

  Future<TodoEntity?> addItem(String email, String content,
      [int? timeStamp]) async {
    _todoCollection = await _todoCollectionFirebase.getCollection(
        email, ModelString.toDoCollection);
    if (_todoCollection != null) {
      final docRef = await _todoCollection!.add(TodoEntity(
              content, timeStamp ?? DateTime.now().millisecondsSinceEpoch)
          .toMap());
      final snapshot = await docRef.get();
      log("Snapshot: ${snapshot}");
      if (snapshot.exists)
        return TodoEntity.toJson(snapshot.data()! as Map<String, dynamic>);
      return null;
    } else {
      log("Could not find Todo Collection");
    }
  }

  Future<List<TodoEntity?>> getAllItems(String email) async {
    _todoCollection = await _todoCollectionFirebase.getCollection(
        email, ModelString.toDoCollection);

    if (_todoCollection != null) {
      final docs = await _todoCollection!.get();
      final items = docs.docs
          .map((e) => TodoEntity.toJson(e.data() as Map<String, dynamic>))
          .toList();
      return items;
    }
    return [];
  }
}
