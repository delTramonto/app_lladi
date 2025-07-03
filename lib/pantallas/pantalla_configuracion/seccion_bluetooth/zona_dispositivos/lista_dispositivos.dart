import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/dispositivo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/zona_dispositivos/device_tile.dart';
import 'package:flutter/material.dart';

class ListaDispositivos extends StatelessWidget {
  final List<DispositivoBluetooth>? conectados;

  final List<DispositivoBluetooth>? emparejados;

  final List<DispositivoBluetooth>? escaneados;

  const ListaDispositivos({
    super.key,
    this.conectados,
    this.emparejados,
    this.escaneados,
  });

  List<Widget> _envolverDispositivos(List<DispositivoBluetooth> disp) {
    final List<Widget> objetos = [];

    if (disp.isNotEmpty) {
      objetos.addAll(
        disp.map((elemento) {
          return Devicetile(dispositivo: elemento);
        }),
      );
    }

    return objetos;
  }

  List<Widget> _crearSeccion({
    Text? tituloSeccion,
    List<DispositivoBluetooth>? dispositivos,
  }) {
    bool? noEstaVacia = dispositivos?.isNotEmpty;

    noEstaVacia ??= false;

    if (noEstaVacia) {
      final List<Widget> dispConfigurados = [];

      if (tituloSeccion != null) {
        dispConfigurados.add(tituloSeccion);
      }

      dispConfigurados.addAll(_envolverDispositivos(dispositivos!));

      return dispConfigurados;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> disp = [];

    disp.addAll(
      _crearSeccion(
        tituloSeccion: const Text("----- Dispositivos Conectados -----"),
        dispositivos: conectados,
      ),
    );

    disp.addAll(
      _crearSeccion(
        tituloSeccion: const Text("----- Dispositivos Guardados -----"),
        dispositivos: emparejados,
      ),
    );

    disp.addAll(
      _crearSeccion(
        tituloSeccion: const Text("----- Dispositivos Disponibles -----"),
        dispositivos: escaneados,
      ),
    );

    return ListView(padding: EdgeInsets.all(12), children: disp);
  }
}
