import 'package:app_prob_pomodoro/utils/manejar_sonido.dart';
import 'package:app_prob_pomodoro/view_models/pomodoro_provider.dart';
import 'package:app_prob_pomodoro/views/widgets/boton_mas.dart';
import 'package:app_prob_pomodoro/views/widgets/botones_opciones.dart';
import 'package:app_prob_pomodoro/views/widgets/contenido_opciones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PanelOpciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.blue[300]),
          thickness: WidgetStateProperty.all(5),
          radius: Radius.circular(10),
        ),
        child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 2, 24, 32),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Opciones",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  fontSize: 20
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.pop(context);
                  }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[50],
                  foregroundColor: Colors.deepOrange[300],
                  side: BorderSide(
                    color: Colors.deepOrange[300]!,
                    width: 2,
                  )
                ),
              ),
            ],
          ),
          SizedBox(height: 25,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16)
            ),
            child: ContenidoOpciones(
            texto: "Tiempo Enfoque", 
            chips: [
              BotonesOpciones(
                texto: "15 min", 
                select: context.watch<PomodoroProvider>().config.indiceEnfoque, 
                indice: 1, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoEnfoque(
                    indice: 1
                  );
                }
              ),
              BotonesOpciones(
                texto: "25 min", 
                select: context.watch<PomodoroProvider>().config.indiceEnfoque, 
                indice: 2, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoEnfoque(
                    indice: 2
                  );
                }
              ),
              BotonesOpciones(
                texto: "50 min", 
                select: context.watch<PomodoroProvider>().config.indiceEnfoque, 
                indice: 3, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoEnfoque(
                    indice: 3
                  );
                }
              ),

              if (context.watch<PomodoroProvider>().estaActivoPersonalizado(TipoPersonalizado.enfoque))
              BotonesOpciones(
                texto: "${context.watch<PomodoroProvider>().config.personalizadoEnfoque} min", 
                select: context.watch<PomodoroProvider>().config.indiceEnfoque, 
                indice: 4, 
                esPersonalizado: true,
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoEnfoque(
                    indice: 4
                  );
                }
              ),
              BotonMas(
                tipo: TipoPersonalizado.enfoque,
              ),
            ]
          ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(16)
            ),
            child: ContenidoOpciones(
            texto: "Tiempo Descanso", 
            chips: [
              BotonesOpciones(
                texto: "3 min", 
                select: context.watch<PomodoroProvider>().config.indiceDescanso, 
                indice: 1, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescanso(
                    indice: 1
                  );
                }
              ),
              BotonesOpciones(
                texto: "5 min", 
                select: context.watch<PomodoroProvider>().config.indiceDescanso, 
                indice: 2, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescanso(
                    indice: 2
                  );
                }
              ),
              BotonesOpciones(
                texto: "10 min", 
                select: context.watch<PomodoroProvider>().config.indiceDescanso, 
                indice: 3, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescanso(
                    indice: 3
                  );
                }
              ),

              if (context.watch<PomodoroProvider>().estaActivoPersonalizado(TipoPersonalizado.descanso))
              BotonesOpciones(
                texto: "${context.watch<PomodoroProvider>().config.personalizadoDescanso} min", 
                select: context.watch<PomodoroProvider>().config.indiceDescanso, 
                indice: 4, 
                esPersonalizado: true,
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescanso(
                    indice: 4
                  );
                }
              ),
              BotonMas(
                tipo: TipoPersonalizado.descanso,
              ),
            ]
          ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(16)
            ),
            child: ContenidoOpciones(
            texto: "Tiempo Descanso largo", 
            chips: [
              BotonesOpciones(
                texto: "10 min", 
                select: context.watch<PomodoroProvider>().config.indiceDescansoLargo, 
                indice: 1, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescansoLargo(
                    indice: 1
                  );
                }
              ),
              BotonesOpciones(
                texto: "15 min", 
                select: context.watch<PomodoroProvider>().config.indiceDescansoLargo, 
                indice: 2, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescansoLargo(
                    indice: 2
                  );
                }
              ),
              BotonesOpciones(
                texto: "25 min", 
                select: context.watch<PomodoroProvider>().config.indiceDescansoLargo, 
                indice: 3, 
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescansoLargo(
                    indice: 3
                  );
                }
              ),

              if (context.watch<PomodoroProvider>().estaActivoPersonalizado(TipoPersonalizado.descansoLargo))
              BotonesOpciones(
                texto: "${context.watch<PomodoroProvider>().config.personalizadoDescansoLargo} min", 
                select: context.watch<PomodoroProvider>().config.indiceDescansoLargo, 
                indice: 4, 
                esPersonalizado: true,
                presionar: (_){
                  context.read<PomodoroProvider>().setTiempoDescansoLargo(
                    indice: 4
                  );
                }
              ),
              BotonMas(
                tipo: TipoPersonalizado.descansoLargo,
              ),
            ],
          ),
          ),
        ],
      ),
      )
      ),
      )
    );
  }
}