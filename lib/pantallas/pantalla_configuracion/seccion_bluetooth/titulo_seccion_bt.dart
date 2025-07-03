import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TituloSeccionBt extends StatelessWidget {
  const TituloSeccionBt({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManejoBluetooth>(
      builder: (context, bluetooth, child) {
        return Text(
          "Vinculate a un LLadi",

          textAlign: TextAlign.center,

          style: TextStyle(color: Colors.black),
        );
      },
    );
  }
}
