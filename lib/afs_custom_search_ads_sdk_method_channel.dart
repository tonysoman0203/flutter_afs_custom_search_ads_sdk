import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'afs_custom_search_ads_sdk_platform_interface.dart';

/// An implementation of [AfsCustomSearchAdsSdkPlatform] that uses method channels.
class MethodChannelAfsCustomSearchAdsSdk extends AfsCustomSearchAdsSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  late MethodChannel methodChannel;

  MethodChannelAfsCustomSearchAdsSdk({int? id}) {
    methodChannel = MethodChannel('AFSNativeAds/$id');
    methodChannel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'updateFlutterViewHeight':
        int adViewHeight = call.arguments as int;
        return Future.value("Text from native: $adViewHeight");
    }
  }

  @override
  Future<String?> loadAds(String keyword, String adKey) async {
    final result = await methodChannel.invokeMethod("loadAds", {"keyword":keyword, "adKey":adKey});
    return result;
  }

  @override
  Future<String?> buildSearchAdController({required String styleId, required String publisherId}) async {
    final result = await methodChannel.invokeMethod("buildSearchAdController", <String, dynamic>{
      "styleId": styleId,
      "publisherId": publisherId,
    });
    return result;
  }

  @override
  Future<String?> buildSearchAdOptions({int? numOfAdsRequested, bool? preFetch, String? channel}) async {
    final result = await methodChannel.invokeMethod("buildSearchAdOptions",  <String, dynamic>{
      "numOfAdsRequested": numOfAdsRequested,
      "preFetch": preFetch,
      "channel": channel
    });
    return result;
  }
}
