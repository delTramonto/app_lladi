import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotonAccionesBluetooth extends StatelessWidget {
  const BotonAccionesBluetooth({super.key});

  IconData _asignarIcono(ManejoBluetooth bluetooth) {
    IconData icono1 = Icons.settings;

    IconData icono2 = Icons.search;

    if (bluetooth.permisosFaltantes.isNotEmpty ||
        bluetooth.permisosDenegados.isNotEmpty) {
      return icono1;
    } else if (bluetooth.bluetoothEncendido == false) {
      return Icons.bluetooth;
    } else if (bluetooth.necesitaActivarGPS && !bluetooth.gpsEstaEncendido) {
      return icono1;
    } else if (bluetooth.estaEscaneando) {
      return Icons.close;
    } else {
      return icono2;
    }
  }

  String _asignarTexto(ManejoBluetooth bluetooth) {
    String abrirConfig = "Abrir Configuracion";

    String buscar = "Buscar Dispositivos";

    String detener = "Detener Busqueda";

    if (bluetooth.permisosFaltantes.isNotEmpty) {
      return "Otorgar Permisos";
    } else if (bluetooth.permisosDenegados.isNotEmpty) {
      return abrirConfig;
    } else if (bluetooth.bluetoothEncendido == false) {
      return "Activar Bluetooth";
    } else if (bluetooth.necesitaActivarGPS && !bluetooth.gpsEstaEncendido) {
      return abrirConfig;
    } else if (bluetooth.estaEscaneando) {
      return detener;
    } else {
      return buscar;
    }
  }

  void Function()? _asignarFuncionalidad(ManejoBluetooth bluetooth) {
    if (bluetooth.permisosFaltantes.isNotEmpty) {
      return bluetooth.verificarYSolicitarPermisos;
    } else if (bluetooth.permisosDenegados.isNotEmpty) {
      return bluetooth.abrirConfigApp;
    } else if (bluetooth.bluetoothEncendido == false) {
      return bluetooth.encenderBT;
    } else if (bluetooth.necesitaActivarGPS && !bluetooth.gpsEstaEncendido) {
      return bluetooth.abrirConfigGPS;
    } else if (bluetooth.estaEscaneando) {
      return bluetooth.detenerEscaneo;
    } else {
      return bluetooth.iniciarEscaneo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManejoBluetooth>(
      builder: (contexto, bluetooth, child) {
        return ElevatedButton.icon(
          onPressed: _asignarFuncionalidad(bluetooth),

          icon: Icon(_asignarIcono(bluetooth), color: Colors.black),

          label: Text(
            _asignarTexto(bluetooth),
            style: TextStyle(color: Colors.black),
          ),

          style: ElevatedButton.styleFrom(backgroundColor: Color(0xffd7dde8)),
        );
      },
    );
  }
}
