import 'package:app_lladi/pantallas/pantalla_inicial/pantalla_inicial.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      showPerformanceOverlay: false,

      home: const PantallaInicial(),
    );
  }
}
