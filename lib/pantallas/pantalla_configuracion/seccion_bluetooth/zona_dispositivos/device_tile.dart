import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/dispositivo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/zona_dispositivos/texto_estado_conexion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Devicetile extends StatelessWidget {
  final DispositivoBluetooth dispositivo;

  const Devicetile({super.key, required this.dispositivo});

  ///Establece el metodo al que se llamará cuando se presione el ListTile
  ///en funcion al estado del dispositivo.
  void Function()? _asignarAccion(ManejoBluetooth bluetooth) {
    var estado = dispositivo.estado;

    if (estado == EstadoDispositivo.desconectado) {
      return () {
        bluetooth.intentarEmparejarDispositivo(dispositivo);
      };
    } else {
      return () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManejoBluetooth>(
      builder: (contexto, bluetooth, child) {
        return Material(
          color: Colors.transparent,

          child: InkWell(
            onTap: _asignarAccion(bluetooth),
            child: ListTile(
              onTap: _asignarAccion(bluetooth),

              title: Text(dispositivo.nombre ?? "Dispositivo Desconocido"),

              subtitle: TextoEstadoConexion(dispositivo: dispositivo),

              subtitleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 62, 59, 59),
              ),
            ),
          ),
        );
      },
    );
  }
}

/*ListTile(
          onTap: _asignarAccion(bluetooth),

          title: Text(dispositivo.nombre ?? "Dispositivo Desconocido"),

          subtitle: TextoEstadoConexion(dispositivo: dispositivo),

          subtitleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 62, 59, 59),
          ),
        );*/
