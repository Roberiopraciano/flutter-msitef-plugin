// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_msitef_plugin/flutter_msitef_plugin.dart';

void main() {
  // Inicializa o binding para testes de integração
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Define um teste de widgets
  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    // Cria uma instância do plugin FlutterMsitefPlugin
    final FlutterMsitefPlugin plugin = FlutterMsitefPlugin();
    // Chama o método getPlatformVersion do plugin e aguarda o resultado
    final String? version = await plugin.getPlatformVersion();
    // A string de versão depende da plataforma host que está executando o teste,
    // então apenas verifica se alguma string não vazia é retornada.
    expect(version?.isNotEmpty, true);
  });
}
