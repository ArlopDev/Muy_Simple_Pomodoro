import 'package:app_prob_pomodoro/utils/ManejarSonido.dart';
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
    ManejarSonido.reproducir("tapBoton.mp3");
    funcion();
  }

  @override
  Widget build(BuildContext context) {

    return ElevatedButton.icon(
      onPressed: onPresionar,
      icon: Icon(icono, size: 25,color: Colors.white,),
      label: Text(texto, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
    );
  }
}

  