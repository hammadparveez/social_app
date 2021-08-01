import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/email_link_model.dart';



class LoginNotifier extends ChangeNotifier {
  final loginModel = EmailLinkAuthModel();

  Future<void> login(String email) async {
    await loginModel.login(email);
  }

}