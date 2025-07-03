import 'package:app_lladi/pantallas/decoraciones/gradients.dart';
import 'package:flutter/material.dart';

class Seccion extends StatelessWidget {
  final double? altura;

  final List<Widget> contenido;

  final Decoration? decoracion;

  final EdgeInsetsGeometry? padding;

  final AlignmentGeometry? alineacion;

  const Seccion({
    super.key,
    this.decoracion,
    this.padding,
    this.altura,
    this.alineacion,
    required this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alineacion,

      height: altura,

      padding: padding,

      decoration: BoxDecoration(
        gradient: Gradients.gray1,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Center(child: Column(children: contenido)),
    );
  }
}
