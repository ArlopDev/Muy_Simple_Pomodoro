import 'package:app_prob_pomodoro/view_models/pomodoro_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/screens/pomodoro_inicio.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PomodoroProvider()),
    ],
    child: MaterialApp(
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
    ),
  ));
}
