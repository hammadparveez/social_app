import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/repository/email_link_repo.dart';

class LoginNotifier extends ChangeNotifier {
  final emailLinkRepo = EmailLinkRepository();

  Future<void> attachDynamicLinkGenerate() =>
      emailLinkRepo.attachDynamicLinkListener();

  Future<void> login(String email) async {}
}
