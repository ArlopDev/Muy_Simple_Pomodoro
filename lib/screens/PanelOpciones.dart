import 'package:app_prob_pomodoro/widgets/BotonMas.dart';
import 'package:app_prob_pomodoro/widgets/BotonesOpciones.dart';
import 'package:app_prob_pomodoro/widgets/ContenidoOpciones.dart';
import 'package:flutter/material.dart';


class PanelOpciones extends StatefulWidget {

  final Function(int) onEnfoqueChanged;
  final Function(int) onDescansoChanged;
  final Function(int) onDescansoLargoChanged;
  final int enfoqueInicial;
  final int descansoInicial;
  final int descansoLargoInicial;

  const PanelOpciones({
    required this.onEnfoqueChanged,
    required this.onDescansoChanged,
    required this.onDescansoLargoChanged,
    required this.enfoqueInicial,
    required this.descansoInicial,
    required this.descansoLargoInicial
  });

  @override
  State<PanelOpciones> createState() => _PanelOpcionesState();  
}

class _PanelOpcionesState extends State<PanelOpciones>{
  
  @override
  void initState() {
    super.initState();
    selecEnfoque = _minutosAIndice(widget.enfoqueInicial, [15, 25, 50]);
    selecDescanso = _minutosAIndice(widget.descansoInicial, [3, 5, 10]);
    selecDescansoLargo = _minutosAIndice(widget.descansoLargoInicial, [10, 15, 25]);
  }

  int _minutosAIndice(int minutos, List<int> opciones) {
    int indice = opciones.indexOf(minutos);
    return indice == -1 ? 0 : indice + 1; // 0 si es personalizado
  }

  int selecModo = 0;
  int selecEnfoque = 2;
  int selecDescanso = 2;
  int selecDescansoLargo = 2;

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
                onPressed: (){Navigator.pop(context);}, 
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
          SizedBox(height: 20,),
          ContenidoOpciones(
            texto: "Modos rápidos", 
            chips: [
              BotonesOpciones(texto: "Suave", select: selecModo, indice: 1, 
              presionar: (_){setState(() {
                selecModo = 1;
                selecEnfoque = 1;
                selecDescanso = 1;
                selecDescansoLargo = 1;
                widget.onEnfoqueChanged(15);
                widget.onDescansoChanged(3);
                widget.onDescansoLargoChanged(10);
              });},),
              BotonesOpciones(texto: "Normal", select: selecModo, indice: 2, 
              presionar: (_){setState(() {
                selecModo = 2;
                selecEnfoque = 2;
                selecDescanso = 2;
                selecDescansoLargo = 2;
                widget.onEnfoqueChanged(25);
                widget.onDescansoChanged(5);
                widget.onDescansoLargoChanged(15);
              });},),
              BotonesOpciones(texto: "Intenso", select: selecModo, indice: 3, 
              presionar: (_){setState(() {
                selecModo = 3;
                selecEnfoque = 3;
                selecDescanso = 3;
                selecDescansoLargo = 3;
                widget.onEnfoqueChanged(50);
                widget.onDescansoChanged(10);
                widget.onDescansoLargoChanged(25);
              });},),
            ]
          ),
          SizedBox(height: 5,),
          Divider(
            height: 5,
            thickness: 1,
            color: Colors.grey[300]
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16)
            ),
            child: ContenidoOpciones(
            texto: "Enfoque", 
            chips: [
              BotonesOpciones(texto: "15", select: selecEnfoque, indice: 1, 
              presionar: (_){setState(() {
                selecEnfoque = 1;
                selecModo = 0;
                widget.onEnfoqueChanged(15);
              });},),
              BotonesOpciones(texto: "25", select: selecEnfoque, indice: 2, 
              presionar: (_){setState(() {
                selecEnfoque = 2;
                selecModo = 0;
                widget.onEnfoqueChanged(25);
              });},),
              BotonesOpciones(texto: "50", select: selecEnfoque, indice: 3, 
              presionar: (_){setState(() {
                selecEnfoque = 3;
                selecModo = 0;
                widget.onEnfoqueChanged(50);
              });},),
              //BotonMas(funcion: (){}),
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
            texto: "Descanso", 
            chips: [
              BotonesOpciones(texto: "3", select: selecDescanso, indice: 1, 
              presionar: (_){setState(() {
                selecDescanso = 1;
                selecModo = 0;
                widget.onDescansoChanged(3);
              });},),
              BotonesOpciones(texto: "5", select: selecDescanso, indice: 2, 
              presionar: (_){setState(() {
                selecDescanso = 2;
                selecModo = 0;
                widget.onDescansoChanged(5);
              });},),
              BotonesOpciones(texto: "10", select: selecDescanso, indice: 3, 
              presionar: (_){setState(() {
                selecDescanso = 3;
                selecModo = 0;
                widget.onDescansoChanged(10);
              });},),
              //BotonMas(funcion: (){}),
            ]
          ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.deepOrange[50],
              borderRadius: BorderRadius.circular(16)
            ),
            child: ContenidoOpciones(
            texto: "Descanso largo", 
            chips: [
              BotonesOpciones(texto: "10", select: selecDescansoLargo, indice: 1, 
              presionar: (_){setState(() {
                selecDescansoLargo = 1;
                selecModo = 0;
                widget.onDescansoLargoChanged(10);
              });},),
              BotonesOpciones(texto: "15", select: selecDescansoLargo, indice: 2, 
              presionar: (_){setState(() {
                selecDescansoLargo = 2;
                selecModo = 0;
                widget.onDescansoLargoChanged(15);
              });},),
              BotonesOpciones(texto: "25", select: selecDescansoLargo, indice: 3, 
              presionar: (_){setState(() {
                selecDescansoLargo = 3;
                selecModo = 0;
                widget.onDescansoLargoChanged(25);
              });},),
              //BotonMas(funcion: (){}),
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