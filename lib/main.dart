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
  
  int minutosMaximos = 0;

  String estado = "trabajo";
  String textoEstado = "Trabajo";

  Timer? timerGeneral;

  bool estadoContador = false;

  int contadorTrabajo = 1;

  bool pulsado = false;

  void reiniciar(){
    minutosMaximos = 0;
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

  void agregarMinuto(){
    setState(() {
      if(minutosMaximos < 5 && estado == "trabajo"){
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
      minutosMaximos = 0;
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
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: estadoContador ? 150 : 80,
            ),
            AnimatedOpacity(
              opacity: estadoContador ? 0.0 : 1.0, 
              duration: Duration(milliseconds: 600),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 730),
                curve: Curves.easeInOut,
                height: estadoContador ? 0 : 30,
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
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
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
                    child: AnimatedCrossFade(
                      firstChild: Text("$contadorMinutos:${contadorSegundos.toString().padLeft(2,"0")}",
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ), 
                      secondChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("$contadorMinutos:${contadorSegundos.toString().padLeft(2,"0")}",
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ), 
                        Text("pausado",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ), 
                      crossFadeState: estadoContador ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                      duration: Duration(milliseconds: 600),
                    ),
                    
                  )
                ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 730),
              curve: Curves.easeInOut,
              height: 60,
            ),
            Text(textoEstado,
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            AnimatedOpacity(
              opacity: estadoContador ? 0.0 : 1.0,
              duration: Duration(milliseconds: 600),
              child: IgnorePointer(
                ignoring: estadoContador,
                child: AnimatedContainer(
                duration: Duration(milliseconds: 730),
                curve: Curves.easeInOut,
                height: estadoContador ? 0 : 160,
                child: Column(
                  children: [
                    SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: agregarMinuto, 
                          icon: Icon(Icons.add, size: 25,color: Colors.blue[600],),
                          label: Text("1 minuto",style: TextStyle(fontWeight: FontWeight.bold,),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            foregroundColor: Colors.blue[800],
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
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
                        ElevatedButton.icon(
                          onPressed: reiniciar, 
                          icon: Icon(Icons.refresh, size: 20,color: Colors.blue[600],),
                          label: Text("Reiniciar",style: TextStyle(fontWeight: FontWeight.bold,),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            foregroundColor: Colors.blue[800],
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                        SizedBox(width: 15,),
                        ElevatedButton.icon(
                          onPressed: saltarSeccion, 
                          icon: Icon(Icons.keyboard_double_arrow_right_outlined, size: 25,color: Colors.blue[600],),
                          label: Text("Saltar",style: TextStyle(fontWeight: FontWeight.bold,),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            foregroundColor: Colors.blue[800],
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
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



class CirculoReloj extends CustomPainter{
  final double progreso;
  final Color color;

  CirculoReloj({required this.progreso, required this.color});

  @override
  void paint(Canvas canvas, Size size){
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    Paint fondoPaint = Paint()
      ..color = Colors.grey[400]!
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