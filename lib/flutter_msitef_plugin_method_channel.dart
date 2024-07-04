import 'package:flutter/services.dart';

import 'flutter_msitef_plugin_platform_interface.dart';
import '../src/msitef_response.dart';
import '../src/msitef_response_fail.dart';

/// An implementation of [FlutterMsitefPluginPlatform] that uses method channels.
class MethodChannelFlutterMsitefPlugin extends FlutterMsitefPluginPlatform {
  /// The method channel used to interact with the native platform.
  final MethodChannel _methodChannel =
      const MethodChannel('flutter_msitef_plugin');

  MSitefCallbackSuccess? _callback;
  MSitefCallbackFail? _callbackFail;

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await _methodChannel.invokeMethod<String>('msitef#getPlatformVersion');
    return version;
  }

  @override
  Future<void> msitefAdm({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#adm',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  @override
  Future<void> msitefCredito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#credito',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  @override
  Future<void> msitefDebito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#credito',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  @override
  Future<void> msitefPix({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#pix',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  @override
  Future<void> msitefCarteiraDigital({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#carteiras',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  @override
  Future<void> msitefCancelamento({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#cancelamento',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  @override
  Future<void> msitefOutros({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    await msitefExecuteMethod(
        method: 'msitef#outros',
        params: params,
        callback: callback,
        callbackFail: callbackFail);
  }

  Future<void> msitefExecuteMethod({
    required String method,
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) async {
    setMsitefResultHandler();

    _callback = callback;
    _callbackFail = callbackFail;

    await _methodChannel.invokeMethod(method, params);
  }

  void setMsitefResultHandler() {
    _methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onMsitefResult") {
        final status = Map<String, dynamic>.from(call.arguments)['STATUS'];

        if (status == 'RESULT_OK') {
          final response =
              MSitefResponse.fromMap(Map<String, dynamic>.from(call.arguments));

          if (_callback != null) {
            await _callback!(response);
          }
        } else {
          final response = MSitefResponseFail.fromMap(
              Map<String, dynamic>.from(call.arguments));

          if (_callbackFail != null) {
            await _callbackFail!(response);
          }
        }
      }
    });
  }
}
