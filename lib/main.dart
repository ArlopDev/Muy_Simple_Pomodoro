import 'package:flutter/material.dart';
import 'dart:async';

void main(){
  runApp(MaterialApp(home: Pomodoro(),debugShowCheckedModeBanner: false,));
}

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
  
  String estado = "trabajo";
  String textoEstado = "Trabajo";

  Timer? timerGeneral;

  bool estadoContador = false;

  int contadorTrabajo = 1;

  bool pulsado = false;

  void reiniciar(){
    setState(() {
      pausarTimer();
      estadoContador = false;
      contadorSegundos = 0;
      elegirEstado();
    });
  }

  void saltarSeccion(){
    setState(() {
      pausarTimer();
      estadoContador = false;
      cambiarEstado();
      elegirEstado();
    });
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
      cambiarEstado();
      elegirEstado();
      estadoContador = false;
    }
    });
  }

  double calcularProgreso(){
    int tiempoTotal;
    switch (estado){
      case "trabajo":
        tiempoTotal = pomodoro * 60;break;
      case "descanso_corto":
        tiempoTotal = descansoCorto * 60;break;
      case "descanso_largo":
        tiempoTotal = descansoLargo * 60;break;
      default:
        tiempoTotal = 1500;
    }

    int tiempoRestante = (contadorMinutos * 60) + contadorSegundos;
    return tiempoRestante / tiempoTotal;
  }

  void pausarReanudar(){
    setState(() {
      pulsado = true;
      if(estadoContador){
      estadoContador = false;
      pausarTimer();
      }else{
      estadoContador = true;
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
      case "trabajo": contadorMinutos = pomodoro;textoEstado="Trabajo";break;
      case "descanso_corto": contadorMinutos = descansoCorto;textoEstado="Descanso";break;
      case "descanso_largo": contadorMinutos = descansoLargo;textoEstado="Descanso largo";break;
    }
    });
  }

  void cambiarEstado(){
    setState(() {
      switch (estado){
        case "trabajo": 
        if(contadorTrabajo >= 4){
          estado = "descanso_largo";
        }else{
          estado="descanso_corto";
        }
        break;
        case "descanso_corto": estado="trabajo";contadorTrabajo++;break;
        case "descanso_largo": estado="trabajo";contadorTrabajo = 1;break;
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
            SizedBox(height: estadoContador ? 150 : 80,),
            if(!estadoContador)
            Text("Pomodoro $contadorTrabajo/4",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
            SizedBox(height: 30,),
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: pulsado ? Colors.blue.withValues(alpha: 0.4) : Colors.grey.withValues(alpha: 0.3),
                        blurRadius: pulsado ? 25 : 12,
                        spreadRadius: pulsado ? 5 : 0,
                      )
                    ],
                  ),
                ),
                CustomPaint(
                  size: Size(250, 250),
                  painter: CirculoReloj(progreso: calcularProgreso(), color: pulsado ? Colors.blue[300]! : Colors.blue[200]!),
                ),
                GestureDetector(
                  onTap: pausarReanudar,
                  child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$contadorMinutos:${contadorSegundos.toString().padLeft(2,"0")}",
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        if(!estadoContador)
                        Text("pausado",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                ),
              ],
            ),
            SizedBox(height: 60,),
            Text(textoEstado,
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            if(!estadoContador) ...[
              SizedBox(height: 75,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: reiniciar, child: Text("Reiniciar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
                  SizedBox(width: 15,),
                  ElevatedButton(onPressed: saltarSeccion, child: Text("Saltar sección",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
                ],
              ),            
            ]
          ],
        ),
      ),
    );
  }
}



class CirculoReloj extends CustomPainter{
  final double progreso;
  final Color color;

  CirculoReloj({required this.progreso, required this.color});

  @override
  void paint(Canvas canvas, Size size){
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    Paint fondoPaint = Paint()
      ..color = Colors.blueGrey[500]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, fondoPaint);

    Paint progresoPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius), 
      -90 * (3.14159/180),
      -progreso * 360 * (3.14159 / 180),
      true,
      progresoPaint,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}