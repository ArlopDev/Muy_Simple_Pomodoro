import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Pomodoro(),debugShowCheckedModeBanner: false,));
}

class Pomodoro extends StatefulWidget{
  @override
  State<Pomodoro> createState() => _PomodoroState(); 
}

class _PomodoroState extends State<Pomodoro>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            GestureDetector(
              onTap: (){},
              child: Container(//Timer Numero
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ]
              ),
              child: Center(
                child: Text("25:00",
                  style: TextStyle(
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              )
            ),
            ),
            SizedBox(height: 90,),
            Text("Pomodoro",
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
                ElevatedButton(onPressed: (){}, child: Text("Reiniciar")),
                SizedBox(width: 25,),
                ElevatedButton(onPressed: (){}, child: Text("Saltar sección")),
              ],
            ),            
          ],
        ),
      ),
    );
  }
}

