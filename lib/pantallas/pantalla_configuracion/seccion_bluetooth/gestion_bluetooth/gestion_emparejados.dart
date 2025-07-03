import 'dart:developer';

import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/dispositivo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/gestion_permisos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

mixin GestionEmparejados on ChangeNotifier, IGestionPermisosBluetooth {
  final List<BluetoothDevice> _emparejados = [];

  ///Devuelve el listado de dispositivos emparejados en un listado de tipo DispositivoBluetooth
  List<DispositivoBluetooth> obtenerEmparejados() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((dispositivos) {
          if (!_listasIguales(_emparejados, dispositivos)) {
            _emparejados.clear();

            _emparejados.addAll(dispositivos);

            notifyListeners();
          }
        })
        .onError((error, stackTrace) {
          log(
            "Error al obtener los dispositivos Emparejados",
            error: error,
            stackTrace: stackTrace,
            name: "GestionEmparejadosError",
          );

          var errorAString = error.toString();
          if (errorAString.contains("no_permissions") &&
              errorAString.contains("location")) {
            //Llamamos al metodo que debe tener la interfaz IGestionPermisosBluetooth
            necesitaGPS();
          }
        });

    //Realiza el proceso de cambiar el listado de tipo BluetoothDevice a DispositivoBluetooth y
    //es el listado que devuelve el metodo
    return _configurarEmparejados();
  }

  bool _listasIguales(List<BluetoothDevice> a, List<BluetoothDevice> b) {
    final setA = a.map((d) => d.address).toSet();
    final setB = b.map((d) => d.address).toSet();
    return setA.length == setB.length && setA.containsAll(setB);
  }

  ///Transforma el listado "_emparejados" de BluetoothDevice a DispositivosBluetooth
  ///cambia el estado de los dispositivos a "emparejado"
  List<DispositivoBluetooth> _configurarEmparejados() {
    List<DispositivoBluetooth> dispositivos = [];

    dispositivos.addAll(
      _emparejados.map((disp) {
        return DispositivoBluetooth(
          dispositivo: disp,
          estado: EstadoDispositivo.emparejado,
        );
      }).toList(),
    );
    return dispositivos;
  }

  ///Intenta emparejar el dispositivo dado por parametro, NO evalua si el dispositivo ya
  ///esta emparejado antes de iniciar el proceso, tener precaucion con esto ya que
  ///algunos sistemas pueden dar error si se intenta emparejar un dispositivo ya emparejado
  Future<void> intentarEmparejarDispositivo(
    DispositivoBluetooth dispositivo,
  ) async {
    // Cambiamos el estado a "emparejando"
    dispositivo.asignarEstado(EstadoDispositivo.emparejando);
    notifyListeners(); // notificamos que hay un cambio de estado

    try {
      bool? seEmparejo = await FlutterBluetoothSerial.instance
          .bondDeviceAtAddress(dispositivo.direccion);

      if (seEmparejo != null && seEmparejo) {
        dispositivo.asignarEstado(EstadoDispositivo.emparejado);

        _emparejados.add(dispositivo.dispositivo);
      }
    } catch (error) {
      dispositivo.asignarEstado(EstadoDispositivo.desconectado);

      log(
        "Error al emparejar Dispositivo: $error",
        error: error,
        name: "GestorEmparejadosError",
      );
    }

    notifyListeners(); // Siempre notificamos al final
  }
}
