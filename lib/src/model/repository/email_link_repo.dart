import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/model/email_link_model.dart';

class EmailLinkRepository {
  final EmailLinkAuthModel _model = EmailLinkAuthModel();

  void createDynamicLink() {
    _model.createDynamicLink();
  }

  attachDynamicLinkListener() {
    _model.attachListenerOnLinkGenerate(_onSuccess, _onError);
  }

  Future _onSuccess(PendingDynamicLinkData? linkData) async {
    final isLoginAble =
        _model.isEmailSignInLink("${linkData?.link.toString()}");
    log("Signable ${isLoginAble}");
  }

  Future _onError(OnLinkErrorException? error) async {}
}
