import 'package:flutter_msitef_plugin/flutter_msitef_plugin_platform_interface.dart';
import 'package:flutter_msitef_plugin/src/msitef_response.dart';
import 'package:flutter_msitef_plugin/src/msitef_response_fail.dart';


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
    return; // CORREÇÃO APLICADA
  }

  Future<void> msitefCredito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefCredito(
        params: params, callback: callback, callbackFail: callbackFail);
    return; // CORREÇÃO APLICADA
  }

  Future<void> msitefDebito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefDebito(
        params: params, callback: callback, callbackFail: callbackFail);
    return; // CORREÇÃO APLICADA
  }

  Future<void> msitefPix({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefPix(
        params: params, callback: callback, callbackFail: callbackFail);
    return; // CORREÇÃO APLICADA
  }

  Future<void> msitefCarteiraDigital({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefCarteiraDigital(
        params: params, callback: callback, callbackFail: callbackFail);
    return; // CORREÇÃO APLICADA
  }

  Future<void> msitefCancelamento({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefCancelamento(
        params: params, callback: callback, callbackFail: callbackFail);
    return; // CORREÇÃO APLICADA
  }

  Future<void> msitefOutros({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await FlutterMsitefPluginPlatform.instance.msitefOutros(
        params: params, callback: callback, callbackFail: callbackFail);
    return; // CORREÇÃO APLICADA
  }
}