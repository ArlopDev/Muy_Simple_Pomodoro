import 'package:flutter/material.dart';


class BotonesOpciones extends StatelessWidget {
  
  final String texto;
  final int select;
  final int indice;
  final Function(bool) presionar;

  BotonesOpciones ({
    required this.texto,
    required this.select,
    required this.indice,
    required this.presionar
  });

  final Map<String,Color> colores = {
    "activSuave" : Colors.blue[300]!,
    "activNormal" : Colors.green[300]!,
    "activIntenso" : Colors.red[300]!,
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
      selectedColor: Colors.blue[200],
      backgroundColor: Colors.white,
    );
  }
}