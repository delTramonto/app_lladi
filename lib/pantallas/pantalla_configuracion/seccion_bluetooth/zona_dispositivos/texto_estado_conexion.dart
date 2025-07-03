import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/dispositivo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextoEstadoConexion extends StatelessWidget {
  final DispositivoBluetooth dispositivo;

  const TextoEstadoConexion({required this.dispositivo, super.key});

  @override
  Widget build(BuildContext context) {
    EstadoDispositivo estado = dispositivo.estado;

    return Consumer<ManejoBluetooth>(
      builder: (contexto, bluetooth, child) {
        if (estado == EstadoDispositivo.conectado) {
          return const Text("Conectado");
        } else if (estado == EstadoDispositivo.conectando) {
          return const Text("Conectando...");
        } else if (estado == EstadoDispositivo.emparejando) {
          return const Text("Emparejando...");
        } else if (estado == EstadoDispositivo.desconectando) {
          return const Text("Desconectando...");
        } else {
          return const Text("Disponible");
        }
      },
    );
  }
}
