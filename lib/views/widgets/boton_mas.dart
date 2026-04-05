import 'package:app_prob_pomodoro/view_models/pomodoro_provider.dart';
import 'package:app_prob_pomodoro/views/widgets/numero_personalizado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotonMas extends StatefulWidget {

  final TipoPersonalizado tipo;

  const BotonMas({
    required this.tipo,
  });

  @override
  State<BotonMas> createState() => _BotonMasState();
}

class _BotonMasState extends State<BotonMas>{

  @override
  Widget build(BuildContext context) {

    final estaActivo = context.watch<PomodoroProvider>().estaActivoPersonalizado(widget.tipo);

    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => NumeroPersonalizado(
            tipo: widget.tipo,
            valorInicial: context.read<PomodoroProvider>().obtenerValorPersonalizado(widget.tipo),
          ),
        );
      },
      icon: Icon(
        estaActivo ? 
        Icons.edit : Icons.add_circle_outline,
        color: Colors.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.deepOrange[300],
      ),
    );
  }
}
