import 'package:app_lladi/pantallas/pantalla_inicial/galeria/contenedor.dart';
import 'package:flutter/material.dart';

final List<Widget> _items = List.generate(6, (index) => const Contenedor());

class ZonaGaleria extends StatelessWidget {
  const ZonaGaleria({super.key});

  int _calcularColumnas(BoxConstraints restricciones) {
    double anchoDisponible = restricciones.maxWidth;

    if (anchoDisponible / 2 < 120) {
      /*Esta condicional me permite garantizar que si el ancho disponible de pantalla
      dividido entre 2 me devuelve celdas de menor tamaño a 120px entonces que
      la cuadricula solo tenga una columna
      */
      return 1;
    } else if ((anchoDisponible / 240).floor() <= 3) {
      /*Esta condicional me permite evaluar si caben 3 o menos columnas en la
      cuadricula, si es cierto, entonces la columna tendra de 2 a 3 columnas
      dependiendo el resultado de la expresion de abajo.

      Garantizando que las celdas tengan un tamaño de 120px a 240px
      */
      return (anchoDisponible / 240).floor() == 1
          ? 2
          : (anchoDisponible / 240).floor();
    } else {
      /*El numero de columnas que tendra la cuadricula es el resultado de la
      expresion de abajo*/
      return (anchoDisponible / 360).round();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext contexto, BoxConstraints restricciones) {
          return GridView.count(
            childAspectRatio: 1,

            padding: const EdgeInsets.all(8),

            mainAxisSpacing: 8,

            crossAxisSpacing: 8,

            crossAxisCount: _calcularColumnas(restricciones),

            children: _items,

            /*restricciones.maxWidth.floor() > 220 &&
                        restricciones.maxWidth.floor() <= 740
                    ? 2
                    : (restricciones.maxWidth.floor() / 240).floor(),*/
          );
        },
      ),
    );
  }
}

/*
int _calcularColumnas(BoxConstraints restricciones) {
    double anchoDisponible = restricciones.maxWidth;

    if (anchoDisponible / 2 < 120) {
      /*Esta condicional me permite garantizar que si el ancho disponible de pantalla
      dividido entre 2 me devuelve celdas de menor tamaño a 120px entonces que
      la cuadricula solo tenga una columna
      */
      return 1;
    } else if ((anchoDisponible / 240).floor() <= 3) {
      /*Esta condicional me permite evaluar si caben 3 o menos columnas en la
      cuadricula, si es cierto, entonces la columna tendra de 2 a 3 columnas
      dependiendo el resultado de la expresion de abajo.

      Garantizando que las celdas tengan un tamaño de 120px a 240px
      */
      return (anchoDisponible / 240).floor() == 1
          ? 2
          : (anchoDisponible / 240).floor();
    } else {
      /*El numero de columnas que tendra la cuadricula es el resultado de la
      expresion de abajo*/
      return (anchoDisponible / 360).round();
    }
  }*/
