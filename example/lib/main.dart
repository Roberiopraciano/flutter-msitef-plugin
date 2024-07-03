import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'package:flutter_msitef_plugin/flutter_msitef_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntentForm(),
    );
  }
}

class IntentForm extends StatefulWidget {
  const IntentForm({super.key});

  @override
  _IntentFormState createState() => _IntentFormState();
}

class _IntentFormState extends State<IntentForm> {
  final _flutterMsitefPlugin = FlutterMsitefPlugin();
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    "empresaSitef": TextEditingController(text: "00000001"),
    "enderecoSitef": TextEditingController(text: "127.0.0.1;127.0.0.1:20036"),
    "operador": TextEditingController(text: "0001"),
    "data": TextEditingController(text: "20140312"),
    "hora": TextEditingController(text: "150000"),
    "numeroCupom": TextEditingController(text: "1"),
    "numParcelas": TextEditingController(text: "3"),
    "modalidade": TextEditingController(text: "0"),
    "valor": TextEditingController(text: "9000"),
    "CNPJ_CPF": TextEditingController(text: "12345678912345"),
    "timeoutColeta": TextEditingController(text: "30"),
    "tokenRegistroTls": TextEditingController(text: "0000-0000-0000-0000"),
    "comExterna": TextEditingController(text: "4"),
    "otp": TextEditingController(text: "1234567"),
  };

  Map<String, String> getFormValues() {
    return controllers.map((key, controller) => MapEntry(key, controller.text));
  }

  void msitefAdm() async {
    try {
      final formData = getFormValues();
      print("msitefAdm called with data: $formData");

      await _flutterMsitefPlugin.msitefAdm(
        params: formData,
        callback: (MSitefResponse response) {
          print("Resultado m-SiTef SUCCESS: $response");
          // Aqui você pode atualizar seu UI ou lidar com o resultado conforme necessário
          return Future.value();
        },
        callbackFail: (MSitefResponseFail response) {
          final message =
              "Resultado m-SiTef FAIL: ${response.codresp} - ${response.message} ";
          print(message);

          // Aqui você pode atualizar seu UI ou lidar com o resultado conforme necessário
          showToast(message);

          return Future.value();
        },
      );

      // Perform necessary actions with the form data
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao executar msitefAdm: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void msitefVendaCredito() {
    final formData = getFormValues();
    print("msitefVendaCredito called with data: $formData");
    // Perform necessary actions with the form data
  }

  void msitefVendaDebito() {
    final formData = getFormValues();
    print("msitefVendaDebito called with data: $formData");
    // Perform necessary actions with the form data
  }

  void msitefPix() {
    final formData = getFormValues();
    print("msitefPix called with data: $formData");
    // Perform necessary actions with the form data
  }

  void msitefCancel() {
    final formData = getFormValues();
    print("msitefCancel called with data: $formData");
    // Perform necessary actions with the form data
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intent Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...controllers.entries.map((entry) {
                  return TextFormField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: entry.key),
                  );
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: msitefAdm,
                  child: const Text('ADM'),
                ),
                ElevatedButton(
                  onPressed: msitefVendaCredito,
                  child: const Text('VendaCredito'),
                ),
                ElevatedButton(
                  onPressed: msitefVendaDebito,
                  child: const Text('VendaDebito'),
                ),
                ElevatedButton(
                  onPressed: msitefPix,
                  child: const Text('Pix'),
                ),
                ElevatedButton(
                  onPressed: msitefCancel,
                  child: const Text('Cancelamento'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
