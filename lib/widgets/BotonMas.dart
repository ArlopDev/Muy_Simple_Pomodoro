import 'package:app_prob_pomodoro/providers/minutos_provider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class BotonMas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        int valorTemporal = context.read<MinutosProvider>().minutoPersonalizado;

        showDialog(
          context: context,
          builder: (_) => StatefulBuilder(
            builder: (context, setStateDialog) => AlertDialog(
              title: Text("Personalizado"),
              content: NumberPicker(
                  minValue: 1,
                  maxValue: 120,
                  value: valorTemporal,
                  onChanged: (val) {
                    setStateDialog(() {
                      valorTemporal = val;
                    });
                  }),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    context
                      .read<MinutosProvider>()
                      .guardarPersonalizado(num: valorTemporal,);
                    Navigator.pop(context);
                  }, 
                  child: Text("Aceptar"),
                ),
              ],
            ),
          ),
        );
      },
      icon: Icon(
        Icons.add_circle_outline,
        color: Colors.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.deepOrange[300],
      ),
    );
  }
}
