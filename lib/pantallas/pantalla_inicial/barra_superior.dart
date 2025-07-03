import 'package:app_lladi/pantallas/decoraciones/gradients.dart';
import 'package:app_lladi/pantallas/decoraciones/sombras.dart';
import 'package:flutter/material.dart';

class BarraSuperior extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final double? toolbarHeight;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;

  const BarraSuperior({
    super.key,
    this.title,
    this.toolbarHeight,
    this.actions,
    this.actionsPadding,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title,
      toolbarHeight: toolbarHeight,
      actions: actions,
      actionsPadding: actionsPadding,
      flexibleSpace: const _Decoracion(),
    );
  }
}

/*class BarraSuperior extends AppBar {
  BarraSuperior({
    super.key,
    super.actions,
    super.title,
    super.toolbarHeight,
    super.actionsPadding,
    super.clipBehavior,
  }) : super(flexibleSpace: const _Decoracion());
}*/

class _Decoracion extends StatelessWidget {
  const _Decoracion();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: Gradients.blue2,
        boxShadow: sombra1,
      ),
    );
  }
}

/*AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: Text("LLADI"),

        actions: [BotonSubirImagen(), BotonDeConfiguracion()],

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: blueGradient1,
            boxShadow: sombra1,
          ),
        ),
      ),*/
