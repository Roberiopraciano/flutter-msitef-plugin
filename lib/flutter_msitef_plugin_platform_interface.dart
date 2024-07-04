import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_msitef_plugin_method_channel.dart';
import '../src/msitef_response.dart';
import '../src/msitef_response_fail.dart';

typedef MSitefCallbackSuccess = Future<void> Function(MSitefResponse response);
typedef MSitefCallbackFail = Future<void> Function(MSitefResponseFail response);

abstract class FlutterMsitefPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterMsitefPluginPlatform.
  FlutterMsitefPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMsitefPluginPlatform _instance =
      MethodChannelFlutterMsitefPlugin();

  /// The default instance of [FlutterMsitefPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMsitefPlugin].
  static FlutterMsitefPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMsitefPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterMsitefPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> msitefAdm({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError('msitefAdm() has not been implemented.');
  }

  Future<void> msitefCredito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError('msitefCredito() has not been implemented.');
  }

  Future<void> msitefDebito({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError('msitefDebito() has not been implemented.');
  }

  Future<void> msitefPix({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError('msitefPix() has not been implemented.');
  }

  Future<void> msitefCarteiraDigital({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError(
        'msitefCarteiraDigital() has not been implemented.');
  }

  Future<void> msitefCancelamento({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError('msitefCancelamento() has not been implemented.');
  }

  Future<void> msitefOutros({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    throw UnimplementedError('msitefOutros() has not been implemented.');
  }
}
