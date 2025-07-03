import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/dispositivo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/gestion_bluetooth/manejo_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/zona_dispositivos/lista_dispositivos.dart';
import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/zona_dispositivos/advertencias_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*Esta Clase devuelve un widget ListaDispositivos si hay dispositivos a mostrar
Si no, devuelve un widget AdvertenciasBT */
class ZonaDispositivos extends StatelessWidget {
  const ZonaDispositivos({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManejoBluetooth>(
      builder: (contexto, bluetooth, child) {
        Widget child;

        //var vinculados = bluetooth.dispositivosConectados();

        List<DispositivoBluetooth> guardados = [];

        List<DispositivoBluetooth> escaneados = [];

        if (bluetooth.requisitosCumplidos()) {
          //necesito asegurarme de que los requisitos esten cumplidos antes de estas instrucciones
          //porque si no, dara error
          guardados.addAll(bluetooth.obtenerEmparejados());

          escaneados.addAll(bluetooth.dispositivosEscaneados());
        }

        if (!bluetooth.requisitosCumplidos() ||
            guardados.isEmpty && escaneados.isEmpty) {
          child = const Center(child: AdvertenciasBluetooth());
        } else {
          child = ListaDispositivos(
            escaneados: escaneados,
            emparejados: guardados,
          );
        }

        //No importa que widget se guarde en la variable child, siempre se envolvera
        //en un SizedBox con una altura de 300px
        return SizedBox(height: 300, child: child);
      },
    );
  }
}
