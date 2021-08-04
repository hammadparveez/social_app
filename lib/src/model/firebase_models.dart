import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/src/model/model_constants.dart';

abstract class BaseFirebaseModel {
  final fireStore = FirebaseFirestore.instance;
}

abstract class FindUserFirebaseModel extends BaseFirebaseModel {
  Future<QuerySnapshot<Map<String, dynamic>>> find(String email);
}

abstract class GetCollectionFirebase extends BaseFirebaseModel {
  Future getCollection(String email, String collection);
}

class FindLoggedInUserFirebase extends FindUserFirebaseModel {
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> find(String email) async {
    final snapshot = await fireStore
        .collection(ModelString.usersCollection)
        .where("email", isEqualTo: email)
        .get();
    return snapshot;
  }
}

class GetTodoCollectionFirebase extends GetCollectionFirebase {
  final FindUserFirebaseModel findUserModel = FindLoggedInUserFirebase();
  CollectionReference? _todoCollection;

  Future<CollectionReference?> getCollection(
      String email, String todoCollection) async {
    final snapshot = await findUserModel.find(email);

    for (int i = 0; i < snapshot.docs.length; i++) {
      final el = snapshot.docs[i];
      _todoCollection = fireStore
          .collection(ModelString.usersCollection)
          .doc(el.id)
          .collection(todoCollection);
      break;
    }
    return _todoCollection;
  }
}
