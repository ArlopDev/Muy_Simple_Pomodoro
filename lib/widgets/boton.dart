import 'package:flutter/material.dart';

class MiBoton extends StatelessWidget{

  final VoidCallback funcion;
  final IconData icono;
  final String texto;
  final Color? color;

  const MiBoton({
    required this.funcion,
    required this.icono,
    required this.texto,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: funcion, 
      icon: Icon(icono, size: 25,color: Colors.white,),
      label: Text(texto, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue[300],
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

  