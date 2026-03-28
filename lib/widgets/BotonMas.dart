import 'package:flutter/material.dart';

class BotonMas extends StatelessWidget {
  final VoidCallback funcion;

  const BotonMas({
    required this.funcion,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {}, 
      icon: Icon(Icons.add_circle_outline, color: Colors.white,),
      style: IconButton.styleFrom(
        backgroundColor: Colors.deepOrange[300],
      ),
    );
  }
}