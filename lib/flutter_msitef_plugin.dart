export '../src/msitef_response.dart';
export '../src/msitef_response_fail.dart';

import 'flutter_msitef_plugin_platform_interface.dart';

class FlutterMsitefPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterMsitefPluginPlatform.instance.getPlatformVersion();
  }

  Future<void> msitefAdm({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefAdm(
        params: params, callback: callback, callbackFail: callbackFail);
  }
}
