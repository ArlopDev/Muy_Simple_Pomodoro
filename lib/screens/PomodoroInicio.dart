import 'dart:async';
import 'dart:math';

import 'package:app_prob_pomodoro/screens/PanelOpciones.dart';
import 'package:flutter/material.dart';

import '../widgets/CirculoReloj.dart' show CirculoReloj;
import '../utils/ManejarSonido.dart';
import '../widgets/BotonBase.dart';

import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import 'package:shared_preferences/shared_preferences.dart';

//import '../utils/Alertas.dart';

class PomodoroInicio extends StatefulWidget {
  @override
  State<PomodoroInicio> createState() => _PomodoroInicioState();
}

class _PomodoroInicioState extends State<PomodoroInicio> {

  @override
  void initState() {
    super.initState();
    cargarOpciones();
  }

  Future<void> guardarOpciones() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tiempoPomodoro', tiempoPomodoro);
    await prefs.setInt('descansoCorto', descansoCorto);
    await prefs.setInt('descansoLargo', descansoLargo);
  }

  Future<void> cargarOpciones() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tiempoPomodoro = prefs.getInt('tiempoPomodoro') ?? 25;
      descansoCorto = prefs.getInt('descansoCorto') ?? 5;
      descansoLargo = prefs.getInt('descansoLargo') ?? 15;
    });
  }

  int tiempoPomodoro = 25;
  int descansoCorto = 5;
  int descansoLargo = 15;

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

  void ejecutarReinicio() {
    minutosMaximos = 0;
    setState(() {
      pausarTimer();
      contando = false;
      contadorSegundos = 0;
      elegirEstado();
    });
  }

  void saltarSeccion() {
    setState(() {
      pausarTimer();
      contando = false;
      cambiarEstado();
      elegirEstado();
    });
  }

  void decrementar() {
    setState(() {
      contadorSegundos--;
      if (contadorSegundos < 0) {
        contadorSegundos = 59;
        contadorMinutos--;
      }
    });

    if (contadorMinutos == 0 && contadorSegundos == 0) {
      pausarTimer();
      String texto = "";
      if (estado == "enfoque") {
        texto = mensajeAleatorio(mensajesDescanso);
      } else {
        texto = mensajeAleatorio(mensajesEnfoque);
      }
      ManejarSonido.reproducir("finish.mp3");
      Vibration.vibrate(pattern: [0, 300, 70, 300, 70, 600]);
      setState(() {
        cambiarEstado();
        elegirEstado();
        contando = false;
      });
    }
  }

  double calcularProgreso() {
    int tiempoTotal;
    switch (estado) {
      case "enfoque":
        tiempoTotal = (tiempoPomodoro + minutosMaximos) * 60;
        break;
      case "descanso_corto":
        tiempoTotal = (descansoCorto + minutosMaximos) * 60;
        break;
      case "descanso_largo":
        tiempoTotal = (descansoLargo + minutosMaximos) * 60;
        break;
      default:
        tiempoTotal = 1500;
    }

    int tiempoRestante = (contadorMinutos * 60) + contadorSegundos;
    return tiempoRestante / tiempoTotal;
  }

  void pausarReanudar() {
    setState(() {
      pulsado = true;
      if (contando) {
        contando = false;
        pausarTimer();
      } else {
        contando = true;
        ManejarSonido.reproducir("start.mp3");
        HapticFeedback.mediumImpact();
        iniciarTimer();
      }

      Future.delayed(Duration(milliseconds: 150), () {
        setState(() {
          pulsado = false;
        });
      });
    });
  }

  void iniciarTimer() {
    timerGeneral = Timer.periodic(Duration(seconds: 1), (opcional) {
      decrementar();
    });
  }

  void pausarTimer() {
    timerGeneral?.cancel();
  }

  void elegirEstado() {
    setState(() {
      contadorSegundos = 0;
      switch (estado) {
        case "enfoque":
          contadorMinutos = tiempoPomodoro;
          textoEstado = "Enfoque";
          break;
        case "descanso_corto":
          contadorMinutos = descansoCorto;
          textoEstado = "Descanso";
          break;
        case "descanso_largo":
          contadorMinutos = descansoLargo;
          textoEstado = "Descanso largo";
          break;
      }
    });
  }

  void cambiarEstado() {
    setState(() {
      minutosMaximos = 0;
      switch (estado) {
        case "enfoque":
          if (contadorTrabajo >= 4) {
            estado = "descanso_largo";
          } else {
            estado = "descanso_corto";
          }
          break;
        case "descanso_corto":
          estado = "enfoque";
          contadorTrabajo++;
          break;
        case "descanso_largo":
          estado = "enfoque";
          contadorTrabajo = 1;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.yellow[50],
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 730),
                    curve: Curves.easeInOut,
                    height: contando ? alto * 0.01 : alto * 0.12,
                  ),
                  Text(
                    textoEstado,
                    style: TextStyle(
                      fontSize: ancho * 0.11,
                      fontWeight: FontWeight.w500,
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
                  AnimatedOpacity(
                    opacity: contando ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 600),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 730),
                      curve: Curves.easeInOut,
                      height: contando ? 0 : alto * 0.05,
                      child: Text(
                        "Pomodoro $contadorTrabajo/4",
                        style: TextStyle(
                          fontSize: ancho * 0.071,
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                        ),
                      ),
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
                                BotonBase(
                                    funcion: ejecutarReinicio,
                                    icono: Icons.refresh,
                                    texto: "Reiniciar"),
                                SizedBox(width: ancho * 0.04),
                                BotonBase(
                                    funcion: saltarSeccion,
                                    icono: Icons
                                        .keyboard_double_arrow_right_outlined,
                                    texto: "Saltar"),
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
            Positioned(
              top: alto * 0.06,
              right: ancho * 0.04,
              child: AnimatedOpacity(
                opacity: contando ? 0.0 : 1, 
                duration: Duration(milliseconds: 600),
                child: IgnorePointer(
                  ignoring: contando,
                  child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  width: contando ? ancho * 0.01 : ancho * 0.13,
                  child: IconButton(
                    icon: Icon(
                      Icons.settings, 
                      color: Colors.deepOrange[300],
                      size: 32,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        useSafeArea: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )
                        ),
                        backgroundColor: Colors.yellow[50],
                        builder: (context){
                          return PanelOpciones(
                            enfoqueInicial: tiempoPomodoro,
                            descansoInicial: descansoCorto,
                            descansoLargoInicial: descansoLargo,
                            onEnfoqueChanged: (minutos) {
                              setState(() {
                                tiempoPomodoro = minutos;
                                ejecutarReinicio();
                                guardarOpciones();
                              });
                            },
                            onDescansoChanged: (minutos) {
                              setState(() {
                                descansoCorto = minutos;
                                ejecutarReinicio();
                                guardarOpciones();
                              });
                            },
                            onDescansoLargoChanged: (minutos) {
                              setState(() {
                                descansoLargo = minutos;
                                ejecutarReinicio();
                                guardarOpciones();
                              });
                            },
                          );
                        }
                      );
                    },
                  ),
                )
                )
              )
            )
          ],
        ));
  }
}
