import 'package:app_lladi/pantallas/decoraciones/sombras.dart';
import 'package:flutter/material.dart';

class Contenedor extends StatelessWidget {
  const Contenedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),

      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,

        boxShadow: sombra1,

        border: Border.all(color: Colors.black, width: 2),
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Aqui va la imagen")),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Titulo de la imagen"), Text("Autor")],
          ),
        ],
      ),
    );
  }
}
