import 'package:social_app/src/business_logic/auth_notifier/login_notifier.dart';
import 'package:social_app/src/export.dart';

final loginPod = ChangeNotifierProvider((_) => LoginNotifier());