import 'package:flutter/material.dart';

class CirculoReloj extends StatelessWidget {
  
  final bool pulsado;
  final double calcularProgreso;
  final VoidCallback pausarReanudar;
  final int contadorMinutos;
  final int contadorSegundos;
  final bool contando;

  const CirculoReloj({
    required this.pulsado, 
    required this.calcularProgreso,
    required this.pausarReanudar,
    required this.contadorMinutos,
    required this.contadorSegundos,
    required this.contando,
  });


  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  painter: CirculoCarga(progreso: calcularProgreso, color: pulsado ? Colors.blue[300]! : Colors.blue[200]!),
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
                      crossFadeState: contando ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                      duration: Duration(milliseconds: 600),
                    ),
                    
                  )
                ),
                ),
              ],
            );
  }
}


class CirculoCarga extends CustomPainter{
  final double progreso;
  final Color color;

  CirculoCarga({required this.progreso, required this.color});

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