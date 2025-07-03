import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AdvertenciasBluetooth extends StatelessWidget {
  const AdvertenciasBluetooth({super.key});

  String _asignarTexto(ManejoBluetooth bluetooth) {
    List<Permission> permisosNegados = bluetooth.permisosDenegados;

    if (permisosNegados.isNotEmpty) {
      return "Para continuar, asegúrate de otorgar los permisos necesarios";
    } else if (bluetooth.bluetoothEncendido == false) {
      return "Parece que el Bluetooth está apagado. Actívalo para poder continuar";
    } else if (bluetooth.necesitaActivarGPS && !bluetooth.gpsEstaEncendido) {
      return "Para esta versión de Android, es necesario activar el GPS para buscar dispositivos";
    } else if (bluetooth.estaEscaneando) {
      return "Buscando dispositivos...";
    } else {
      return "Todo listo, presiona el boton para buscar dispositivos";
    }
  }

  IconData _asignarIcono(ManejoBluetooth bluetooth) {
    List<Permission> permisosNegados = bluetooth.permisosDenegados;

    if (permisosNegados.isNotEmpty) {
      return Icons.privacy_tip;
    } else if (bluetooth.bluetoothEncendido == false) {
      return Icons.bluetooth_disabled;
    } else if (bluetooth.necesitaActivarGPS && !bluetooth.gpsEstaEncendido) {
      return Icons.location_off;
    } else if (bluetooth.estaEscaneando) {
      return Icons.search;
    } else {
      return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManejoBluetooth>(
      builder: (contexto, bluetooth, child) {
        return Column(
          //centra el contenido al centro horizontalmente y verticalmente
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(_asignarIcono(bluetooth)),
            Text(_asignarTexto(bluetooth), textAlign: TextAlign.center),
          ],
        );
      },
    );
  }
}
