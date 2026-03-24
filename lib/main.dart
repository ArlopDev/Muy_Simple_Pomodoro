import 'package:flutter/material.dart';
import 'screens/PomodoroInicio.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: "fuenteGeneral"),
    home: PomodoroInicio(),
    debugShowCheckedModeBanner: false,
    builder: (context, child) {
      final mediaQuery = MediaQuery.of(context);
      return MediaQuery(data: mediaQuery.copyWith(
        textScaler: TextScaler.linear(
          mediaQuery.textScaler.scale(1.0).clamp(0.9, 1.2)
        )
      ), child: child!);
    },
  ));
}
