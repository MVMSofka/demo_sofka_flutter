import 'package:flutter/services.dart';

// Creamos la clase SettingMethodChannel que se encarga de enviar una nota a la plataforma nativa utilizando MethodChannel
class SettingMethodChannel {
// Instancia de MethodChannel con el nombre "flutter"
  static const methodChannel = MethodChannel('flutter');

  // Método para regresar a IOS
  Future<void> backToHome() async {
    try {
      await (methodChannel.invokeMethod('backToHome'));
    } on PlatformException catch (exception) {
      print("$exception");
    }
  }

  void sendFlutterMessage(String message) async {
    try {
      await methodChannel.invokeMethod('sendFlutterMessage', message);
    } on PlatformException catch (exception) {
      print("$exception");
    }
  }
}
