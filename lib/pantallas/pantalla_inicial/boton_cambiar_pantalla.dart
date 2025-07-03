import 'package:flutter/material.dart';

class BotonCambiarPantalla extends StatelessWidget {
  final IconData icono;
  final Color colorIcono;
  final Widget Function() destino;
  const BotonCambiarPantalla({
    super.key,
    required this.destino,
    required this.icono,
    required this.colorIcono,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext contexto, BoxConstraints restricciones) {
        return IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => destino()),
            );
          },
          iconSize: restricciones.maxHeight * 0.8,

          icon: Icon(icono, color: colorIcono),
        );
      },
    );
  }
}
