import 'package:social_app/src/business_logic/register_notifier/register_notifier.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/user_model.dart';

final registerUserPod =
    ChangeNotifierProvider((ref) => RegisterUserNotifier(UserModelImpl()));
