import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/CirculoReloj.dart' show CirculoReloj;
import '../utils/ManejarSonido.dart';
import '../widgets/BotonBase.dart';

import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

//import '../utils/Alertas.dart';

class PomodoroInicio extends StatefulWidget{
  @override
  State<PomodoroInicio> createState() => _PomodoroInicioState(); 
}

class _PomodoroInicioState extends State<PomodoroInicio>{
  
  final int tiempoPomodoro = 25;
  final int descansoCorto = 5;
  final int descansoLargo = 15;

  int contadorMinutos = 25;
  int contadorSegundos = 0;
  
  int minutosMaximos = 0;

  String estado = "enfoque";
  String textoEstado = "Enfoque";

  Timer? timerGeneral;

  bool contando = false;

  int contadorTrabajo = 1;

  bool pulsado = false;


  int agregarMinutosMax = 5;

  final List<String> mensajesDescanso = [
    "Buen trabajo, tómate un descanso.",
    "¡Sesión completada! Hora de relajarte.",
    "Bien hecho, despeja la mente un momento.",
    "Gran progreso, descansa un poco.",
    "Tu cerebro te lo agradece, pausa un momento."
  ];

  final List<String> mensajesEnfoque = [
    "Listos para volver.",
    "Descanso terminado, ¡sigamos!",
    "Hora de concentrarse otra vez.",
    "Energía renovada, continuemos.",
    "Vamos por otra sesión."
  ];

  String mensajeAleatorio(List<String> lista) {
    final random = Random();
    return lista[random.nextInt(lista.length)];
  }

  // void reiniciar(){
  //   Alertas.mostrarConfirmacion(context: context, titulo: "¿Reiniciar?", mensaje: "Solo el contador actual", accion: ejecutarReinicio);
  // }

  void ejecutarReinicio(){
    minutosMaximos = 0;
    setState(() {
      pausarTimer();
      contando = false;
      contadorSegundos = 0;
      elegirEstado();
    });
  }

  void saltarSeccion(){
    setState(() {
      pausarTimer();
      contando = false;
      cambiarEstado();
      elegirEstado();
    });
  }

  // void agregarMinuto(){
  //   setState(() {
  //     if(minutosMaximos < agregarMinutosMax && estado == "enfoque"){
  //       contadorMinutos++;
  //       minutosMaximos++;
  //     }
  //     if(minutosMaximos < agregarMinutosMax && (estado == "descanso_corto" || estado == "descanso_largo")){
  //       contadorMinutos++;
  //       minutosMaximos++;
  //     }
  //   });
  //   calcularProgreso();
  // }

  void decrementar() {
    setState(() {
      contadorSegundos--;
    if(contadorSegundos < 0){
      contadorSegundos = 59;
      contadorMinutos--;
    }
    });

    if(contadorMinutos == 0 && contadorSegundos == 0){
      pausarTimer();
      String texto = "";
      if(estado == "enfoque"){
        texto = mensajeAleatorio(mensajesDescanso);
      }else{
        texto = mensajeAleatorio(mensajesEnfoque);
      }
      ManejarSonido.reproducir("finish.mp3");
      Vibration.vibrate(pattern: [0, 300, 70, 300]);
      setState(() {
        cambiarEstado();
        elegirEstado();
        contando = false;
      });
    }
  }

  double calcularProgreso(){
    int tiempoTotal;
    switch (estado){
      case "enfoque":
        tiempoTotal = (tiempoPomodoro + minutosMaximos) * 60;break;
      case "descanso_corto":
        tiempoTotal = (descansoCorto + minutosMaximos) * 60;break;
      case "descanso_largo":
        tiempoTotal = (descansoLargo + minutosMaximos) * 60;break;
      default:
        tiempoTotal = 1500;
    }

    int tiempoRestante = (contadorMinutos * 60) + contadorSegundos;
    return tiempoRestante / tiempoTotal;
  }

  void pausarReanudar(){
    setState(() {
      pulsado = true;
      if(contando){
      contando = false;
      pausarTimer();
      }else{
      contando = true;
      ManejarSonido.reproducir("start.mp3");
      HapticFeedback.mediumImpact();
      iniciarTimer();
      }

      Future.delayed(Duration(milliseconds: 150),(){
        setState(() {
          pulsado = false;
        });
      });
    });
  }

  void iniciarTimer(){
    timerGeneral = Timer.periodic(Duration(seconds: 1),(opcional){decrementar();});
  }

  void pausarTimer(){
    timerGeneral?.cancel();
  }

  void elegirEstado(){
    setState(() {
      contadorSegundos = 0;
      switch (estado){
      case "enfoque": contadorMinutos = tiempoPomodoro;textoEstado="Enfoque";break;
      case "descanso_corto": contadorMinutos = descansoCorto;textoEstado="Descanso";break;
      case "descanso_largo": contadorMinutos = descansoLargo;textoEstado="Descanso largo";break;
    }
    });
  }

  void cambiarEstado(){
    setState(() {
      minutosMaximos = 0;
      switch (estado){
        case "enfoque": 
        if(contadorTrabajo >= 4){
          estado = "descanso_largo";
        }else{
          estado="descanso_corto";
        }
        break;
        case "descanso_corto": estado="enfoque";contadorTrabajo++;break;
        case "descanso_largo": estado="enfoque";contadorTrabajo = 1;break;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: contando ? alto * 0.01 : alto * 0.09,
            ),
            AnimatedOpacity(
              opacity: contando ? 0.0 : 1.0,
              duration: Duration(milliseconds: 600),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 730),
                curve: Curves.easeInOut,
                height: contando ? 0 : alto * 0.05,
                child: Text("Pomodoro $contadorTrabajo/4",
                  style: TextStyle(
                    fontSize: ancho * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: alto * 0.04,
            ),
            CirculoReloj(
              pulsado: pulsado,
              calcularProgreso: calcularProgreso(),
              pausarReanudar: pausarReanudar,
              contadorMinutos: contadorMinutos,
              contadorSegundos: contadorSegundos,
              contando: contando,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: alto * 0.07,
            ),
            Text(textoEstado,
              style: TextStyle(
                fontSize: ancho * 0.09,
                fontWeight: FontWeight.w500,
              ),
            ),
            AnimatedOpacity(
              opacity: contando ? 0.0 : 1.0,
              duration: Duration(milliseconds: 600),
              child: IgnorePointer(
                ignoring: contando,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 730),
                  curve: Curves.easeInOut,
                  height: contando ? 0 : alto * 0.22,
                  child: Column(
                    children: [
                      SizedBox(height: alto * 0.04),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 730),
                        curve: Curves.easeInOut,
                        height: alto * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonBase(funcion: ejecutarReinicio, icono: Icons.refresh, texto: "Reiniciar"),
                          SizedBox(width: ancho * 0.04),
                          BotonBase(funcion: saltarSeccion, icono: Icons.keyboard_double_arrow_right_outlined, texto: "Saltar"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}