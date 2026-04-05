import 'package:app_prob_pomodoro/utils/manejar_sonido.dart';
import 'package:flutter/material.dart';

class BotonBase extends StatelessWidget{

  final VoidCallback funcion;
  final IconData? icono;
  final String texto;
  final Color? color;

  const BotonBase({
    required this.funcion,
    this.icono,
    required this.texto,
    this.color,
  });

  void onPresionar(){
    funcion();
  }

  @override
  Widget build(BuildContext context) {

    return ElevatedButton.icon(
      onPressed: onPresionar,
      icon: Icon(icono, size: 25,color: Colors.blue[300],),
      label: Text(texto, style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[50],
        overlayColor: Colors.blue[300],
        shadowColor: Colors.blue[900],
        foregroundColor: Colors.blue[300],
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: Colors.blue[300]!,
          width: 1.5
        )
      ),
    );
  }
}

  