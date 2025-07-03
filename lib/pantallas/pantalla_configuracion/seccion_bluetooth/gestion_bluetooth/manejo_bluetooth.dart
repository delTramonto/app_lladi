import 'dart:developer';

import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestion_emparejados.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestion_escaneados.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestion_permisos_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestor_estado_bluetooth.dart';
import 'package:flutter/material.dart';

//TODO monitorear el estado del gps si el dispositivo necesita gps
//TODO mejorar el codigo del metodo que verifica si el app volvio a primer plano
class ManejoBluetooth extends ChangeNotifier
    with
        GestionPermisosBluetooth,
        GestionEscaneados,
        GestionEmparejados,
        GestorEstadoBluetooth,
        WidgetsBindingObserver {
  ManejoBluetooth() {
    obtenerVerificarYSolicitarPermisos().then((valor) {
      monitorearEstadoBluetooth();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  ///Evalua si todos los requisitos necesarios estan cumplidos para poder realizar acciones
  ///con el bluetooth
  bool requisitosCumplidos() {
    if (permisosDenegados.isEmpty &&
        bluetoothEncendido &&
        necesitaActivarGPS &&
        gpsEstaEncendido) {
      return true;
    } else if (permisosDenegados.isEmpty &&
        bluetoothEncendido &&
        !necesitaActivarGPS) {
      return true;
    } else {
      return false;
    }
  }

  ///
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      verificarYSolicitarPermisos();
    }
  }

  @override
  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
    } on Exception catch (e) {
      log(
        "Error al cancelar la suscripcion al cambio de estado del app: $e",
        error: e,
        name: "ManejoBluetoothError",
      );
    }
    super.dispose();
  }
}
