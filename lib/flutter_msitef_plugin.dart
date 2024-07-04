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

  Future<void> msitefCredito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefCredito(
        params: params, callback: callback, callbackFail: callbackFail);
  }

  Future<void> msitefDebito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefDebito(
        params: params, callback: callback, callbackFail: callbackFail);
  }

  Future<void> msitefPix({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefPix(
        params: params, callback: callback, callbackFail: callbackFail);
  }

  Future<void> msitefCarteiraDigital({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefCarteiraDigital(
        params: params, callback: callback, callbackFail: callbackFail);
  }

  Future<void> msitefCancelamento({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefCancelamento(
        params: params, callback: callback, callbackFail: callbackFail);
  }

  Future<void> msitefOutros({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefOutros(
        params: params, callback: callback, callbackFail: callbackFail);
  }
}
