import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_msitef_plugin/flutter_msitef_plugin.dart';
import 'package:flutter_msitef_plugin/flutter_msitef_plugin_platform_interface.dart';
import 'package:flutter_msitef_plugin/flutter_msitef_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMsitefPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMsitefPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> msitefAdm({
    required Map<String, String> params,
    required MSitefCallbackSuccess callback,
    MSitefCallbackFail? callbackFail,
  }) {
    // TODO: implement msitefAdm
    throw UnimplementedError();
  }
}

void main() {
  final FlutterMsitefPluginPlatform initialPlatform =
      FlutterMsitefPluginPlatform.instance;

  test('$MethodChannelFlutterMsitefPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMsitefPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterMsitefPlugin flutterMsitefPlugin = FlutterMsitefPlugin();
    MockFlutterMsitefPluginPlatform fakePlatform =
        MockFlutterMsitefPluginPlatform();
    FlutterMsitefPluginPlatform.instance = fakePlatform;

    expect(await flutterMsitefPlugin.getPlatformVersion(), '42');
  });
}
