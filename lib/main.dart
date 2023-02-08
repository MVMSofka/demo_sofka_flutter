import 'package:demo_sofka_flutter/views/my_app.dart';
import 'package:flutter/material.dart';

// Este decorador indica al compilador de Flutter que esta función debe usarse como
// punto de entrada para la aplicación.
@pragma('vm:entry-point')
void flutterEntryPoint() => runApp(const MyApp());

void main() => runApp(const MyApp());
