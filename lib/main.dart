import 'package:flutter/material.dart';
import 'screens/PomodoroInicio.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(home: PomodoroInicio(),debugShowCheckedModeBanner: false,));
}







