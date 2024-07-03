import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_msitef_plugin/flutter_msitef_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterMsitefPlugin = FlutterMsitefPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterMsitefPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> msitefAdm() async {
    try {
      Map<String, String> params = {
        "empresaSitef": "00000001",
        "enderecoSitef": "127.0.0.1;127.0.0.1:20036",
        "operador": "0001",
        "data": "20140312",
        "hora": "150000",
        "numeroCupom": "1",
        "modalidade": "2",
        "valor": "9000",
        "restricoes": "TransacoesHabilitadas=16",
        "CNPJ_CPF": "71245600125",
        "timeoutColeta": "30",
        "acessibilidadeVisual": "0"
      };

      await _flutterMsitefPlugin.msitefAdm(
        params: params,
        callback: (MSitefResponse response) {
          print("Resultado m-SiTef SUCCESS: ${response.codresp}");
          // Aqui você pode atualizar seu UI ou lidar com o resultado conforme necessário
          return Future.value();
        },
        callbackFail: (MSitefResponseFail response) {
          print(
              "Resultado m-SiTef FAIL: ${response.codresp} - ${response.message} ");
          // Aqui você pode atualizar seu UI ou lidar com o resultado conforme necessário
          return Future.value();
        },
      );
    } on Exception {
      setState(() {
        _platformVersion = 'deu erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () {
                  msitefAdm();
                },
                child: const Text('ADM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
