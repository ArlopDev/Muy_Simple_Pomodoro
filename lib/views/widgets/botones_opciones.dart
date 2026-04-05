import 'package:app_prob_pomodoro/utils/manejar_sonido.dart';
import 'package:flutter/material.dart';


class BotonesOpciones extends StatelessWidget {
  
  final String texto;
  final int select;
  final int indice;
  final Function(bool) presionar;
  final bool esPersonalizado; 

  BotonesOpciones ({
    required this.texto,
    required this.select,
    required this.indice,
    required this.presionar,
    this.esPersonalizado = false,
  });

  final Map<String,Color> colores = {
    "personalizadoActivo" : Colors.deepOrange[300]!,
    "perosnalizadoDesactivado" : Colors.deepOrange[50]!,
    "normalActivo" : Colors.blue[200]!,
    "normalDesactivado" : Colors.white,
  }; 

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(texto,), 
      labelStyle: TextStyle(
        color: select == indice ? Colors.white : Colors.black,
        fontSize: 16,
        fontWeight: select == indice ? FontWeight.bold : FontWeight.normal,
      ),
      
      selected: select == indice,
      onSelected: presionar,
      showCheckmark: false,
      selectedColor: esPersonalizado 
        ? colores["personalizadoActivo"]
        : colores["normalActivo"],
      backgroundColor: esPersonalizado 
        ? colores["perosnalizadoDesactivado"]
        : colores["normalDesactivado"],
    );
  }
}