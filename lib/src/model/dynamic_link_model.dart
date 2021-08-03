import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/model/model_constants.dart';

abstract class DynamicLinkModel {
  final dynamicLink = FirebaseDynamicLinks.instance;
  //Returns with Shorten URL
  Future<Uri> createDynamicLink();

  void attachListenerOnLinkGenerate(
      Future<dynamic> Function(PendingDynamicLinkData? linkData) onSuccess,
      Future<dynamic> Function(OnLinkErrorException? error) onError);
}

class DynamicLinkGenerator extends DynamicLinkModel {
  @override
  Future<Uri> createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: ModelString.dynamicLinkHTTPS,
      link: Uri.parse(ModelString.baseUri),
      androidParameters: AndroidParameters(
        packageName: ModelString.pkgName,
        minimumVersion: ModelString.dynamicAndroidVersion,
      ),
      iosParameters: IosParameters(
        bundleId: ModelString.pkgName,
        minimumVersion: '${ModelString.dynamicAppleVersion}',
        appStoreId: '123',
      ),
    );
    return await _shortenDynamicLink(parameters);
  }

  Future<Uri> _shortenDynamicLink(DynamicLinkParameters parameters) async {
    var dynamicUrl = await parameters.buildShortLink();
    final shortUrl = dynamicUrl.shortUrl;
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    log("URL : ${shortUrl}");
    return shortUrl;
  }

  @override
  void attachListenerOnLinkGenerate(
      Future<dynamic> Function(PendingDynamicLinkData? linkData) onSuccess,
      Future<dynamic> Function(OnLinkErrorException? error) onError) {
    dynamicLink.onLink(onSuccess: onSuccess, onError: onError);
  }
}
