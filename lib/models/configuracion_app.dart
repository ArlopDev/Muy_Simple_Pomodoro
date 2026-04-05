
class ConfiguracionApp {
  final int tiempoEnfoque;
  final int tiempoDescanso;
  final int tiempoDescansoLargo;

  final int personalizadoEnfoque;
  final int personalizadoDescanso;
  final int personalizadoDescansoLargo;

  final int indiceEnfoque;
  final int indiceDescanso;
  final int indiceDescansoLargo;

  ConfiguracionApp({
    required this.tiempoEnfoque,
    required this.tiempoDescanso,
    required this.tiempoDescansoLargo,
    required this.personalizadoEnfoque,
    required this.personalizadoDescanso,
    required this.personalizadoDescansoLargo,
    required this.indiceEnfoque,
    required this.indiceDescanso,
    required this.indiceDescansoLargo,
  });

  factory ConfiguracionApp.defaults() {
    return ConfiguracionApp(
      tiempoEnfoque: 25,
      tiempoDescanso: 5,
      tiempoDescansoLargo: 15,
      personalizadoEnfoque: 0,
      personalizadoDescanso: 0,
      personalizadoDescansoLargo: 0,
      indiceEnfoque: 2,
      indiceDescanso: 2,
      indiceDescansoLargo: 2
    );
  }

  ConfiguracionApp copyWith({
    int? tiempoEnfoque,
    int? tiempoDescanso,
    int? tiempoDescansoLargo,
    int? personalizadoEnfoque,
    int? personalizadoDescanso,
    int? personalizadoDescansoLargo,
    int? indiceEnfoque,
    int? indiceDescanso,
    int? indiceDescansoLargo,
  }) {
    return ConfiguracionApp(
        tiempoEnfoque: tiempoEnfoque ?? this.tiempoEnfoque,
        tiempoDescanso: tiempoDescanso ?? this.tiempoDescanso,
        tiempoDescansoLargo: tiempoDescansoLargo ?? this.tiempoDescansoLargo,
        personalizadoEnfoque: personalizadoEnfoque ?? this.personalizadoEnfoque,
        personalizadoDescanso:
            personalizadoDescanso ?? this.personalizadoDescanso,
        personalizadoDescansoLargo:
            personalizadoDescansoLargo ?? this.personalizadoDescansoLargo,
        indiceEnfoque: indiceEnfoque ?? this.indiceEnfoque,
        indiceDescanso: indiceDescanso ?? this.indiceDescanso,
        indiceDescansoLargo: indiceDescansoLargo ?? this.indiceDescansoLargo);
  }
}
