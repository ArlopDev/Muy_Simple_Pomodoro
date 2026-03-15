import 'package:flutter/material.dart';

class Alertas {

  static void mostrarConfirmacion({
    required BuildContext context,
    required String titulo, 
    required String mensaje, 
    required VoidCallback accion, 
  }){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        title: Center(child: Text(titulo, style: TextStyle(fontWeight: FontWeight.w500),)) ,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              Text(mensaje, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16), textAlign: TextAlign.justify ,)
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Cancelar", 
                style: TextStyle()),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  accion();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Confirmar"),
              ),
            ],
          )
        ],
      ),
    );
  }
  
}