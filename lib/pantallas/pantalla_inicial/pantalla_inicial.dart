import 'package:app_lladi/pantallas/pantalla_configuracion/pantalla_de_configuracion.dart';
import 'package:app_lladi/pantallas/pantalla_inicial/barra_superior.dart';
import 'package:app_lladi/pantallas/pantalla_inicial/boton_cambiar_pantalla.dart';
import 'package:app_lladi/pantallas/pantalla_inicial/boton_subir_imagen.dart';
import 'package:app_lladi/pantallas/pantalla_inicial/galeria/zona_galeria.dart';
import 'package:flutter/material.dart';

List<BotonCambiarPantalla> _botonesPantallas = [
  BotonCambiarPantalla(
    destino:
        () =>
            const PantallaDeConfiguracion(), //hace falta declarar el destino como const
    icono: Icons.account_circle,
    colorIcono: Colors.black,
  ),

  BotonCambiarPantalla(
    destino:
        () =>
            const PantallaDeConfiguracion(), //hace falta declarar el destino como const
    icono: Icons.settings,
    colorIcono: Colors.black,
  ),
];

class PantallaInicial extends StatelessWidget {
  const PantallaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperior(
        toolbarHeight: 70,

        title: const Text("APP LLADI"),

        actionsPadding: const EdgeInsets.all(8),

        actions: _botonesPantallas,
      ),

      floatingActionButton: const BotonSubirImagen(),

      body: const ZonaGaleria(),
    );
  }
}
