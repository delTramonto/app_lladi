import 'dart:async';
import 'dart:developer';

import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestion_escaneados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:geolocator/geolocator.dart' as gps;

//TODO hacer que los procesos pertinentes se ejecuten en segundo plano.
//TODO darle una revision a los metodos para emparejar y vincular dispositivos
//TODO crear mecanismo para verificar que el dispositivo sea valido

mixin GestorEstadoBluetooth on ChangeNotifier, IGestionEscaneados {
  bool _estaEncendido = false;

  bool _gpsEncendido = false;

  bool get bluetoothEncendido => _estaEncendido;

  bool get gpsEstaEncendido => _gpsEncendido;

  ///Almacena la suscripcion al estado del bluetooth
  StreamSubscription<BluetoothState>? _suscripcionEstadoBluetooth;

  ///Almacena la suscripcion al estado del GPS
  StreamSubscription<gps.ServiceStatus>? _suscripcionEstadoGPS;

  void encenderBT() => FlutterBluetoothSerial.instance.requestEnable();

  void abrirConfigGPS() => gps.Geolocator.openLocationSettings();

  ///Obtiene el estado actual del bluetooth y escuchas cambios del estado en tiempo real
  Future<void> monitorearEstadoBluetooth() async {
    // 1. Verifica el estado actual del adaptador Bluetooth al momento de llamar a .state
    try {
      var estadoInicial = await FlutterBluetoothSerial.instance.state;

      _estaEncendido = estadoInicial.isEnabled;

      notifyListeners();
    } on Exception catch (e) {
      log(
        "Error al obtener el estado actual del adaptador Bluetooth \n",
        error: e,
        name: "GestorBluetoothError",
      );
    }

    //Obtiene el Stream de estados del adaptador Bluetooth
    var estadoBluetooth = FlutterBluetoothSerial.instance.onStateChanged();

    /* Crea una suscripcion para escuchar cambios de estado del adaptador Bluetooth
    en tiempo real, primero verifica si no hay una suscripcion ya activa*/
    try {
      _suscripcionEstadoBluetooth ??= estadoBluetooth.listen((estadoActual) {
        if (estadoActual.isEnabled) {
          _estaEncendido = true;

          notifyListeners();
        } else if (!estadoActual.isEnabled) {
          _estaEncendido = false;

          detenerEscaneo();

          limpiarEscaneados();
        }
      });
    } on Exception catch (e) {
      log(
        "Error al manejar el cambio de estado Bluetooth, $e",
        name: "GestorBluetoothError",
        error: e,
      );
    }
  }

  Future<void> monitorearEstadoGPS() async {
    //Intenta obtener el estado actual del GPS al momento de llamar al metodo isLocationServiceEnabled()
    try {
      var estaEncendido = await gps.Geolocator.isLocationServiceEnabled();

      if (_gpsEncendido != estaEncendido) {
        _gpsEncendido = estaEncendido;

        notifyListeners();
      }
    } on Exception catch (e) {
      log(
        "Error al obtener el estado inicial del gps: $e",
        name: "GestorBluetoothError",
        error: e,
      );
    }

    //Obtiene el Stream de estados del GPS
    var estadoGPS = gps.Geolocator.getServiceStatusStream();

    /*Crea una suscripcion para escuchar cambios de estado del GPS en tiempo real
    primero evalua si no hay una suscripcion ya activa */
    try {
      _suscripcionEstadoGPS ??= estadoGPS.listen((gps.ServiceStatus estado) {
        if (estado == gps.ServiceStatus.enabled) {
          _gpsEncendido = true;

          notifyListeners();
        } else if (estado == gps.ServiceStatus.disabled) {
          _gpsEncendido = false;

          detenerEscaneo();

          limpiarEscaneados();
        }
      });
    } on Exception catch (e) {
      log(
        "Error al obtener el stream de cambios de estado del GPS: $e",
        name: "GestorBluetoothError",
        error: e,
      );
    }
  }

  @override
  void dispose() {
    try {
      _suscripcionEstadoBluetooth?.cancel();

      _suscripcionEstadoBluetooth = null;

      _suscripcionEstadoGPS?.cancel();

      _suscripcionEstadoGPS = null;

      //_suscripcionListaDispositivos?.cancel();
    } on Exception catch (e) {
      log(
        "Error al cancelar suscripciones, $e",
        name: "GestorEstadoBluetoothError",
        error: e,
      );
    }
    super.dispose();
  }
}
