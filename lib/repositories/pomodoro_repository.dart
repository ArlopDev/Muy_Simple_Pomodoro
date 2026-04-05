import 'package:app_prob_pomodoro/models/configuracion_app.dart';
import 'package:app_prob_pomodoro/repositories/keys_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PomodoroRepository {
  final SharedPreferences prefs;

  PomodoroRepository({
    required this.prefs,
  });

  Future<void> guardarOpciones({required ConfiguracionApp conf}) async {
    await prefs.setInt(KeysPrefs.enfoque, conf.tiempoEnfoque);
    await prefs.setInt(KeysPrefs.descanso, conf.tiempoDescanso);
    await prefs.setInt(KeysPrefs.descansoLargo, conf.tiempoDescansoLargo);

    await prefs.setInt(KeysPrefs.personalizadoEnfoque, conf.personalizadoEnfoque);
    await prefs.setInt(KeysPrefs.personalizadoDescanso, conf.personalizadoDescanso);
    await prefs.setInt(KeysPrefs.personalizadoDescansoLargo, conf.personalizadoDescansoLargo);

    await prefs.setInt(KeysPrefs.indiceEnfoque, conf.indiceEnfoque);
    await prefs.setInt(KeysPrefs.indiceDescanso, conf.indiceDescanso);
    await prefs.setInt(KeysPrefs.indiceDescansoLargo, conf.indiceDescansoLargo);
  }

  Future<ConfiguracionApp> cargarOpciones() async {
    return ConfiguracionApp(
      tiempoEnfoque: prefs.getInt(KeysPrefs.enfoque) ?? 25,
      tiempoDescanso: prefs.getInt(KeysPrefs.descanso) ?? 5,
      tiempoDescansoLargo: prefs.getInt(KeysPrefs.descansoLargo) ?? 15,

      personalizadoEnfoque: prefs.getInt(KeysPrefs.personalizadoEnfoque) ?? 0,
      personalizadoDescanso: prefs.getInt(KeysPrefs.personalizadoDescanso) ?? 0,
      personalizadoDescansoLargo: prefs.getInt(KeysPrefs.personalizadoDescansoLargo) ?? 0,

      indiceEnfoque: prefs.getInt(KeysPrefs.indiceEnfoque) ?? 2,
      indiceDescanso: prefs.getInt(KeysPrefs.indiceDescanso) ?? 2,
      indiceDescansoLargo: prefs.getInt(KeysPrefs.indiceDescansoLargo) ?? 2,
    );
  }
}
