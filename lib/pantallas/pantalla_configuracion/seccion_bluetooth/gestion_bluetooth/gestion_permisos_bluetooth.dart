import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

mixin GestionPermisosBluetooth on ChangeNotifier
    implements IGestionPermisosBluetooth {
  bool _necesitaGPS = false;

  bool get necesitaActivarGPS => _necesitaGPS;

  final List<Permission> _denegados = [];

  final List<Permission> _faltantes = [];

  final List<Permission> _necesarios = [];

  List<Permission> get permisosFaltantes => _faltantes;

  List<Permission> get permisosDenegados => _denegados;

  void abrirConfigApp() => openAppSettings();

  @override
  void necesitaGPS() {
    Permission.location.status.then((estado) {
      debugPrint("El estado del permiso Location es: $estado");
    });
    _necesarios.add(Permission.location);

    notifyListeners();
  }

  Future<void> _obtenerPermisosNecesarios() async {
    _necesarios.clear();

    if (Platform.isAndroid) {
      try {
        final deviceInfo = DeviceInfoPlugin();

        final androidInfo = await deviceInfo.androidInfo;

        final version = androidInfo.version.sdkInt;

        if (version >= 31) {
          _necesarios.add(Permission.bluetoothConnect);
          _necesarios.add(Permission.bluetoothScan);
        } else if (version <= 30) {
          _necesitaGPS = true;

          _necesarios.add(Permission.location);
        }
      } on Exception catch (e) {
        log(
          "Error al obtener la version de Android y los permisos necesarios: $e",

          name: "GestionPermisosBluetoothError",

          error: e,
        );
      }
    }
  }

  /// Verifica el estado de los permisos necesarios
  Future<void> verificarEstadoPermisos() async {
    _faltantes.clear();
    _denegados.clear();

    if (_necesarios.isNotEmpty) {
      for (final permiso in _necesarios) {
        try {
          final estado = await permiso.status;

          debugPrint("el estado de $permiso es $estado");

          if (estado.isDenied) {
            _faltantes.add(permiso);
          } else if (estado.isPermanentlyDenied) {
            _denegados.add(permiso);
          }
        } on Exception catch (e) {
          log(
            "Error al verificar el estado del permiso $permiso: $e",
            name: "GestorPermisosBluetoothError",
          );
        }
      }

      notifyListeners();
    }
  }

  /// Solicita los permisos
  Future<void> _solicitarPermisos() async {
    if (_faltantes.isNotEmpty) {
      try {
        await _faltantes.request();
      } on Exception catch (e) {
        log(
          "Error al solicitar los permisos faltantes: $e",
          name: "GestorPermisosBluetoothError",
        );
      }
    }
  }

  Future<void> obtenerVerificarYSolicitarPermisos() async {
    await _obtenerPermisosNecesarios();

    await verificarEstadoPermisos();

    await _solicitarPermisos();
  }

  Future<void> verificarYSolicitarPermisos() async {
    await verificarEstadoPermisos();

    await _solicitarPermisos();
  }
}

abstract class IGestionPermisosBluetooth {
  void necesitaGPS();
}
