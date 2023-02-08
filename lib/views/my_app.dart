// importamos la biblioteca 'material.dart' para poder usar widgets de Flutter.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/setting_method_channel.dart';

// Creamos la clase 'NewNotePage' que hereda de 'StatelessWidget' y sobreescribe el método 'build'.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Sobreescribimos el método build.
  // Creamos un constructor de clase que recibe una clave y la pasa a su padre.
  final SettingMethodChannel settingMethodChannel = SettingMethodChannel();
  final textController = TextEditingController();
  static const platform = MethodChannel("flutter");

  String? _nativeMessage;

  _MyAppState() {
    platform.setMethodCallHandler(_receiveFromHost);
  }

  @override
  Widget build(BuildContext context) {
    // retornamos MaterialApp, que representa la pantalla principal de usuario de la aplicación.
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Note App",
        home: Scaffold(
            appBar: AppBar(
                title: const Text(
              "Flutter 🐦",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(_nativeMessage ?? "",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "Enter the flutter's message",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        settingMethodChannel
                            .sendFlutterMessage(textController.text);
                        settingMethodChannel.backToHome();
                      },
                      child: const Text("Send"))
                ]),
              ),
            )));
  }

  Future<void> _receiveFromHost(MethodCall call) async {
    try {
      if (call.method == "getIOSNativeMessage") {
        final String data = call.arguments;
        print(call.arguments);
        _nativeMessage = await data;
        setState(() {
          _nativeMessage = data;
        });
      }
    } on PlatformException catch (error) {
      print(error);
    }
  }
}
