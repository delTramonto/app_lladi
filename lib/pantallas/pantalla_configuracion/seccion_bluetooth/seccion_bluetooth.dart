import 'package:app_lladi/pantallas/pantalla_configuracion/seccion.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/boton_acciones_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/titulo_seccion_bt.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/zona_dispositivos/zona_dispositivos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeccionBluetooth extends StatelessWidget {
  const SeccionBluetooth({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ManejoBluetooth(),

      child: Seccion(
        alineacion: Alignment.center,

        padding: const EdgeInsets.all(12),

        contenido: [
          const TituloSeccionBt(),

          const SizedBox(height: 8),

          const ZonaDispositivos(),

          const SizedBox(height: 8),

          const BotonAccionesBluetooth(),
        ],
      ),
    );
  }
}
