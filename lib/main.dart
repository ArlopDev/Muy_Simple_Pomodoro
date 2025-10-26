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
      switch (estado){
      case "trabajo": contadorMinutos = pomodoro;textoEstado="Trabajo";break;
      case "descanso_corto": contadorMinutos = descansoCorto;textoEstado="Descanso";break;
      case "descanso_largo": contadorMinutos = descansoLargo;textoEstado="Descanso largo";break;
    }
    });
  }

  void cambiarEstado(){
    switch (estado){
      case "trabajo": 
      if(contadorTrabajo >= 4){
        estado = "descanso_largo";break;
      }else{
        estado="descanso_corto";break;
      }
      case "descanso_corto": estado="trabajo";contadorTrabajo++;break;
      case "descanso_largo": estado="trabajo";contadorTrabajo = 1;break;
    }
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Text("Pomodoro $contadorTrabajo/4",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: pausarReanudar,
              child: AnimatedContainer(//Timer Numero
              duration: Duration(milliseconds: 150),
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pulsado ? Colors.blue[400] : Colors.blue[200],
                boxShadow: [
                  BoxShadow(
                    color: pulsado ? Colors.blue.withValues(alpha: 0.6) : Colors.grey,
                    blurRadius: pulsado ? 20 : 10,
                    offset: Offset(0, 4),
                  )
                ]
              ),
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
                    Text(estadoContador ? "" : "pausado",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            ),
            ),
            SizedBox(height: 60,),
            Text(textoEstado,
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            SizedBox(height: 25,),
            Text("Tu puedes",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 50,),
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
          ],
        ),
      ),
    );
  }
}

