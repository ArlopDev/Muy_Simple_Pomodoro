import 'package:app_prob_pomodoro/i18n/strings.g.dart';
import 'package:app_prob_pomodoro/utils/manejar_sonido.dart';
import 'package:app_prob_pomodoro/view_models/pomodoro_provider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class NumeroPersonalizado extends StatefulWidget {

  final TipoPersonalizado tipo;
  final int valorInicial;

  const NumeroPersonalizado({
    required this.tipo,
    required this.valorInicial,
  });

  @override
  State<NumeroPersonalizado> createState() => _NumeroPersonalizadoState();
}

class _NumeroPersonalizadoState extends State<NumeroPersonalizado>{
  int valorTemporal = 25;

  @override
  void initState() {
    super.initState();
    valorTemporal = widget.valorInicial;
  }
  
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(t.settings.customize,style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),),
      backgroundColor: Colors.yellow[50],
      content: NumberPicker(
          minValue: 0,
          maxValue: 90,
          value: valorTemporal,
          onChanged: (val) {
            setState(() {
              valorTemporal = val;
            });
          },
          textStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          selectedTextStyle: TextStyle(
            fontSize: 34,
            color: Colors.deepOrange[300],
            fontWeight: FontWeight.bold,
          ),
          ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          style: TextButton.styleFrom(
            foregroundColor: Colors.black87,
          ),
          child: Text(t.settings.cancel, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
        ),
        TextButton(
          onPressed: () {
            context.read<PomodoroProvider>().setPersonalizado(tipo: widget.tipo, num: valorTemporal);
            Navigator.pop(context);
          }, 
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepOrange[300],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(
              color: Colors.deepOrange[300]!,
            ),
          ),
          child: Text(t.settings.accept, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    );
  }
}

  




        