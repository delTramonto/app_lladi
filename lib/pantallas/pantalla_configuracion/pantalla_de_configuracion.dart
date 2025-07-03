import 'package:app_lladi/pantallas/pantalla_configuracion/seccion_bluetooth/seccion_bluetooth.dart';
import 'package:app_lladi/pantallas/pantalla_inicial/barra_superior.dart';
import 'package:flutter/material.dart';

class PantallaDeConfiguracion extends StatelessWidget {
  final List<Widget> secciones = const [SeccionBluetooth()];

  const PantallaDeConfiguracion({super.key});

  double _calcularAncho(BoxConstraints restricciones) {
    double anchoDisponible = restricciones.maxWidth;

    if (anchoDisponible < 400) {
      return anchoDisponible;
    } else if ((anchoDisponible / 2) >= 400 && (anchoDisponible / 2) <= 600) {
      return (anchoDisponible / 2);
    } else {
      return 600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraSuperior(
        title: Text("CONFIGURACION"),

        toolbarHeight: 70,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: LayoutBuilder(
              builder: (contexto, restricciones) {
                return Wrap(
                  direction: Axis.horizontal,

                  alignment: WrapAlignment.center,

                  spacing: 12,

                  runSpacing: 12,

                  children:
                      secciones.map((seccion) {
                        return SizedBox(
                          width: _calcularAncho(restricciones) - 24,
                          /*MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? _calcularAncho(restricciones) - 12
                              : _calcularAncho(restricciones),*/
                          child: seccion,
                        );
                      }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
