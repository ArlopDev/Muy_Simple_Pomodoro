import 'package:flutter/material.dart';
import 'screens/PomodoroInicio.dart';
import 'utils/notificacion_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificacionService.inicializar();
  runApp(MaterialApp(home: PomodoroInicio(),debugShowCheckedModeBanner: false,));
}







