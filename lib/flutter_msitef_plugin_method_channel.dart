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
    print('msitefAdm called');
    setMsitefResultHandler();

    _callback = callback;
    _callbackFail = callbackFail;

    await _methodChannel.invokeMethod('msitef#adm', params);
  }

  void setMsitefResultHandler() {
    print('setMsitefResultHandler called');

    _methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onMsitefResult") {
        print('onMsitefResult called');

        final status = Map<String, dynamic>.from(call.arguments)['STATUS'];

        if (status == 'RESPONSE_OK') {
          print('RESPONSE_OK');

          final response =
              MSitefResponse.fromMap(Map<String, dynamic>.from(call.arguments));

          if (_callback != null) {
            await _callback!(response);
          }
        } else {
          print('RESPONSE_CANCELED/OTHERS');

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
