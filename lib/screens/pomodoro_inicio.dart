import 'dart:async';

import 'package:flutter/material.dart';


import '../widgets/circulo_reloj.dart' show CirculoReloj;
import '../utils/sonido.dart';
import '../widgets/boton.dart';

class Pomodoro extends StatefulWidget{

  @override
  State<Pomodoro> createState() => _PomodoroState(); 
}

class _PomodoroState extends State<Pomodoro>{
  
  final int pomodoro = 25;
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


  void reiniciar(){
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

  void agregarMinuto(){
    setState(() {
      if(minutosMaximos < 5 && estado == "enfoque"){
        contadorMinutos++;
        minutosMaximos++;
      }
      if(minutosMaximos < 3 && (estado == "descanso_corto" || estado == "descanso_largo")){
        contadorMinutos++;
        minutosMaximos++;
      }
    });
    calcularProgreso();
  }

  void decrementar(){
    setState(() {
      contadorSegundos--;
    if(contadorSegundos < 0){
      contadorSegundos = 59;
      contadorMinutos--;
    }
    if(contadorMinutos == 0 && contadorSegundos == 0){
      pausarTimer();
      MiSonido.reproducir("finish.mp3");
      cambiarEstado();
      elegirEstado();
      contando = false;
    }
    });
  }

  double calcularProgreso(){
    int tiempoTotal;
    switch (estado){
      case "enfoque":
        tiempoTotal = (pomodoro + minutosMaximos) * 60;break;
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
      MiSonido.reproducir("start.mp3");
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
      case "enfoque": contadorMinutos = pomodoro;textoEstado="Enfoque";break;
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
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: contando ? 150 : 80,
            ),
            AnimatedOpacity(
              opacity: contando ? 0.0 : 1.0, 
              duration: Duration(milliseconds: 600),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 730),
                curve: Curves.easeInOut,
                height: contando ? 0 : 30,
                child: Text("Pomodoro $contadorTrabajo/4",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: 30,
            ),
            CirculoReloj(
              pulsado: pulsado, 
              calcularProgreso: calcularProgreso(), 
              pausarReanudar: pausarReanudar, 
              contadorMinutos: contadorMinutos, 
              contadorSegundos: contadorSegundos, 
              contando: contando
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: 60,
            ),
            Text(textoEstado,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w500
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
                height: contando ? 0 : 160,
                child: Column(
                  children: [
                    SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MiBoton(funcion: agregarMinuto, icono: Icons.add, texto: "1 minuto")
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 730),
                      curve: Curves.easeInOut,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MiBoton(funcion: reiniciar, icono: Icons.refresh, texto: "Reiniciar"),
                        SizedBox(width: 15,),
                        MiBoton(funcion: saltarSeccion, icono: Icons.keyboard_double_arrow_right_outlined, texto: "Saltar")
                      ],
                    ),
                  ],
                ), 
              ),
              )
            ),
          ],
        ),
      ),
    );
  }
}