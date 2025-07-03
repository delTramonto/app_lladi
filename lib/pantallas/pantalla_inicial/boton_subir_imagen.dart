import 'package:flutter/material.dart';

class BotonSubirImagen extends StatelessWidget {
  const BotonSubirImagen({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,

      onPressed: () {}, // TODO: agregar mecanismo para enviar imagen

      backgroundColor: Colors.amberAccent,

      foregroundColor: Colors.black,

      label: const Text("Enviar Imagen"),

      icon: const Icon(Icons.send_sharp),
    );
  }
}
