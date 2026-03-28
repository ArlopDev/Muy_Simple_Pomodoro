

import 'package:flutter/material.dart';

class ContenidoOpciones extends StatelessWidget {

  final String texto;
  final List<Widget> chips;

  const ContenidoOpciones ({
    required this.texto,
    required this.chips
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(texto,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          SizedBox(height: 8,),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: chips,
          ),
      ],
    );
  }
}