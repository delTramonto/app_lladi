import 'dart:async';

import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/dispositivo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestion_permisos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

//TODO ordenar los dispositivos del mejor rssi a peor antes de devolverlos

///Este mixin permite escanear dispositivos bluetooth y obtener los resultados del escaneo
mixin GestionEscaneados on ChangeNotifier, IGestionPermisosBluetooth
    implements IGestionEscaneados {
  bool _escaneando = false;

  bool get estaEscaneando => _escaneando;

  //Listado donde se almacenan los resultados del escaneo
  final List<BluetoothDiscoveryResult> _escaneados = [];

  ///Almacena la suscripcion al proceso de escaneado de dispositivos
  StreamSubscription<BluetoothDiscoveryResult>? _suscripcionStreamEscaneados;

  ///Devuelve la lista de dispositivos escaneados convertidos a objetos de tipo "DispositivoBluetooth"
  List<DispositivoBluetooth> dispositivosEscaneados() {
    if (_escaneados.isNotEmpty) {
      List<DispositivoBluetooth> dispositivos = [];

      /*Se recorre el listado "_escaneados" en cada itearcion se agrega a "dispositivos"
      una instancia de "DispositivoBluetooth" con el elemento de que cada posicion como
      argumento para el parametro "dispositivo" */
      for (final elemento in _escaneados) {
        dispositivos.add(DispositivoBluetooth(dispositivo: elemento.device));
      }

      return dispositivos;
    } else {
      return <DispositivoBluetooth>[];
    }
  }

  @override
  void limpiarEscaneados() {
    _escaneados.clear();

    notifyListeners();
  }

  /// Inicia el escaneo de dispositivos Bluetooth.
  Future<void> iniciarEscaneo() async {
    if (!_escaneando) {
      _escaneados.clear();

      _escaneando = true;

      notifyListeners();

      try {
        var escaneoDispositivos =
            FlutterBluetoothSerial.instance.startDiscovery();

        _suscripcionStreamEscaneados ??= escaneoDispositivos.listen((
          BluetoothDiscoveryResult encontrado,
        ) {
          final nombre = encontrado.device.name;

          if (nombre != null && nombre.isNotEmpty) {
            _manejarDispositivoEncontrado(encontrado);
          }
        });

        //Establece lo que se debe hacer cuando el escaneo termina
        _suscripcionStreamEscaneados?.onDone(() {
          debugPrint("El escaneo finalizo");

          detenerEscaneo();
        });

        //Establece lo que se debe hacer en caso de error en el Stream de escaneados
        _suscripcionStreamEscaneados?.onError((error) {
          debugPrint("Error en el escaneo de dispositivos: $error");

          detenerEscaneo();

          var errorAString = error.toString();
          if (errorAString.contains("no_permissions") &&
              errorAString.contains("location")) {
            //Llamamos al metodo que debe tener la interfaz IGestionPermisosBluetooth
            necesitaGPS();
          }
        });
      } catch (e) {
        debugPrint('Error al escanear: $e');

        _escaneando = false;

        notifyListeners();
      }
    }
  }

  ///Se encarga de actualizar el dispositivo si ya existe en "_escaneados"
  ///o agregarlo si no existe
  void _manejarDispositivoEncontrado(BluetoothDiscoveryResult dispositivo) {
    bool yaExiste = false;

    int indice = _escaneados.indexWhere((elemento) {
      yaExiste = elemento.device.address == dispositivo.device.address;

      return yaExiste;
    });

    if (yaExiste) {
      _escaneados[indice] = dispositivo;
    } else {
      _escaneados.add(dispositivo);
    }
  }

  @override
  void detenerEscaneo() {
    if (_escaneando) {
      try {
        _suscripcionStreamEscaneados?.cancel();
      } on Exception catch (e) {
        debugPrint(
          "Error al cancelar la suscripcion al stream de dispositivos escaneados: $e",
        );
      } finally {
        _suscripcionStreamEscaneados = null;

        _escaneando = false;

        notifyListeners();
      }
    }
  }
}

abstract class IGestionEscaneados {
  void limpiarEscaneados();

  void detenerEscaneo();
}
