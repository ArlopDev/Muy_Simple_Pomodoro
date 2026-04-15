import 'package:app_prob_pomodoro/repositories/keys_prefs.dart';
import 'package:app_prob_pomodoro/view_models/pomodoro_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/screens/pomodoro_inicio.dart';
import 'package:flutter/services.dart';
import 'package:app_prob_pomodoro/i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? idioma = prefs.getString(KeysPrefs.idioma);
  if (idioma != null) {
    LocaleSettings.setLocaleRaw(idioma);
  } else {
    final dispositivo = LocaleSettings.useDeviceLocale();
    if (dispositivo != AppLocale.es && dispositivo != AppLocale.en) {
      LocaleSettings.setLocale(AppLocale.en);
    }
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(TranslationProvider(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PomodoroProvider(prefs: prefs)),
      ],
      child: const PomodoroMain(),
    ),
  ));
}

class PomodoroMain extends StatelessWidget {
  const PomodoroMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,

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
    );
  }
}
