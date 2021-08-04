import 'package:social_app/src/business_logic/todo_notifier/todo_notifier.dart';
import 'package:social_app/src/export.dart';

final todoListPod = ChangeNotifierProvider((ref) => TodoNotifier());