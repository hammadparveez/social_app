import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/entites/todo_entity.dart';
import 'package:social_app/src/model/todo_item_model.dart';

class TodoNotifier extends ChangeNotifier {
  final TodoItemModel _itemModel = TodoItemModel();
  List<TodoEntity?> _todoItems = <TodoEntity>[];

  List<TodoEntity?> get todoItems => _todoItems;

  void addItem(String email, String content, [int? timeStamp]) async {
    final todoEntity = await _itemModel.addItem(email, content);
    if (todoEntity != null) _todoItems.add(todoEntity);
    notifyListeners();
  }

  void getAllItems(String email) async {
    _todoItems = await _itemModel.getAllItems(email);
    notifyListeners();
  }
}
