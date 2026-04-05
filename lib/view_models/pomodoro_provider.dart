import 'dart:async';
import 'dart:math';

import 'package:app_prob_pomodoro/models/configuracion_app.dart';
import 'package:app_prob_pomodoro/repositories/pomodoro_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';

import '../utils/manejar_sonido.dart';  

enum TipoPersonalizado {enfoque, descanso, descansoLargo}

class PomodoroProvider extends ChangeNotifier {

  ConfiguracionApp _config = ConfiguracionApp.defaults();

  ConfiguracionApp get config => _config;

  int contadorMinutos = 25;
  int contadorSegundos = 0;

  int contadorSesiones = 1;

  TipoPersonalizado estado = TipoPersonalizado.enfoque;
  String textoEstado = "Enfoque";

  bool pulsado = false;
  bool contando = false;

  PomodoroProvider(){
    _cargarOpciones();
  }

  Future<PomodoroRepository> _obtenerRepo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return PomodoroRepository(prefs: prefs);
  }

  Future<void> _cargarOpciones() async {
    final PomodoroRepository repo = await _obtenerRepo();
    _config = await repo.cargarOpciones();

    contadorMinutos = _config.tiempoEnfoque;
    notifyListeners();
  }

  Future<void> _guardarOpciones() async {
    final PomodoroRepository repo = await _obtenerRepo();
    await repo.guardarOpciones(conf: _config);

    notifyListeners();
  }
  
  void _guardarYReiniciar(TipoPersonalizado tipo){
    if (estado == tipo){
      ejecutarReinicio();
    }
    _guardarOpciones();
  }

  void setTiempoEnfoque({required int indice}){
    _config = _config.copyWith(tiempoEnfoque: _seleccionarTiempoEnfoque(indice), indiceEnfoque: indice);
    _guardarYReiniciar(TipoPersonalizado.enfoque);
    notifyListeners();
  }

  void setPersonalizadoEnfoque({required int indice}){
    _config = _config.copyWith(tiempoEnfoque: _seleccionarTiempoEnfoque(indice), personalizadoEnfoque: _seleccionarTiempoEnfoque(indice), indiceEnfoque: indice);
    _guardarYReiniciar(TipoPersonalizado.enfoque);
    notifyListeners();
  }

  void setTiempoDescanso({required int indice}){
    _config = _config.copyWith(tiempoDescanso: _seleccionarTiempoDescanso(indice), indiceDescanso: indice);
    _guardarYReiniciar(TipoPersonalizado.descanso);
    notifyListeners();
  }

  void setPersonalizadoDescanso({required int indice}){
    _config = _config.copyWith(tiempoDescanso: _seleccionarTiempoDescanso(indice), personalizadoDescanso: _seleccionarTiempoDescanso(indice), indiceDescanso: indice);
    _guardarYReiniciar(TipoPersonalizado.descanso);
    notifyListeners();
  }

  void setTiempoDescansoLargo({required int indice}){
    _config = _config.copyWith(tiempoDescansoLargo: _seleccionarTiempoDescansoLargo(indice), indiceDescansoLargo: indice);
    _guardarYReiniciar(TipoPersonalizado.descansoLargo);
    notifyListeners();
  }

  void setPersonalizadoDescansoLargo({required int indice}){
    _config = _config.copyWith(tiempoDescansoLargo: _seleccionarTiempoDescansoLargo(indice), personalizadoDescansoLargo: _seleccionarTiempoDescansoLargo(indice), indiceDescansoLargo: indice);
    _guardarYReiniciar(TipoPersonalizado.descansoLargo);
    notifyListeners();
  }

  int _seleccionarTiempoEnfoque(int indice){
    switch (indice){
      case 1: return 15;
      case 2: return 25;
      case 3: return 50;
      case 4: return _config.personalizadoEnfoque;
      default: return 25;
    }
  }

  int _seleccionarTiempoDescanso(int indice){
    switch (indice){
      case 1: return 3;
      case 2: return 5;
      case 3: return 10;
      case 4: return _config.personalizadoDescanso;
      default: return 5;
    }
  }

  int _seleccionarTiempoDescansoLargo(int indice){
    switch (indice){
      case 1: return 10;
      case 2: return 15;
      case 3: return 25;
      case 4: return _config.personalizadoDescansoLargo;
      default: return 15;
    }
  }

  bool estaActivoPersonalizado(TipoPersonalizado tipo) {
    return switch (tipo) {
      TipoPersonalizado.enfoque => _config.personalizadoEnfoque > 0,
      TipoPersonalizado.descanso => _config.personalizadoDescanso > 0,
      TipoPersonalizado.descansoLargo => _config.personalizadoDescansoLargo > 0,
    };
  }

  int obtenerValorPersonalizado(TipoPersonalizado tipo){
    return switch (tipo) {
      TipoPersonalizado.enfoque => _config.personalizadoEnfoque,
      TipoPersonalizado.descanso => _config.personalizadoDescanso,
      TipoPersonalizado.descansoLargo => _config.personalizadoDescansoLargo,
    };
  }

  void setPersonalizado({required TipoPersonalizado tipo, required int num}) {
    switch (tipo) {
      case TipoPersonalizado.enfoque: 
        if(num == 0) {
          _config = _config.copyWith(personalizadoEnfoque: 0);
          if(_config.indiceEnfoque == 4){
            setTiempoEnfoque(indice: 2);
          }
        }else{
          _config = _config.copyWith(personalizadoEnfoque: num, tiempoEnfoque: num, indiceEnfoque: 4);
        }
        _guardarYReiniciar(TipoPersonalizado.enfoque);
      case TipoPersonalizado.descanso: 
      if(num == 0){
        _config = _config.copyWith(personalizadoDescanso: 0);
        if(_config.indiceDescanso == 4){
          setTiempoDescanso(indice: 2);
        }
      }else{
        _config = _config.copyWith(personalizadoDescanso: num, tiempoDescanso: num, indiceDescanso: 4);
      }
      _guardarYReiniciar(TipoPersonalizado.descanso);
      case TipoPersonalizado.descansoLargo:
      if (num == 0){
        _config = _config.copyWith(personalizadoDescansoLargo: 0);
        if(_config.indiceDescansoLargo == 4){
          setTiempoDescansoLargo(indice: 2);
        }
      }else{
        _config = _config.copyWith(personalizadoDescansoLargo: num, tiempoDescansoLargo: num, indiceDescansoLargo: 4);
      }
      _guardarYReiniciar(TipoPersonalizado.descansoLargo);
    }
    notifyListeners();
  }


  final List<String> mensajesDescanso = [
    "Buen trabajo, tómate un descanso.",
    "¡Sesión completada! Hora de relajarte.",
    "Bien hecho, despeja la mente un momento.",
    "Gran progreso, descansa un poco.",
    "Tu cerebro te lo agradece, pausa un momento."
  ];

  final List<String> mensajesEnfoque = [
    "Listos para volver.",
    "Descanso terminado, ¡sigamos!",
    "Hora de concentrarse otra vez.",
    "Energía renovada, continuemos.",
    "Vamos por otra sesión."
  ];

  String mensajeAleatorio(List<String> lista) {
    final random = Random();
    return lista[random.nextInt(lista.length)];
  }

  void ejecutarReinicio() {
    pausarTimer();
    contando = false;
    contadorSegundos = 0;
    elegirEstado();
    notifyListeners();
  }

  void saltarSeccion() {
    pausarTimer();
    contando = false;
    cambiarEstado();
    elegirEstado();
    notifyListeners();
  }

  void decrementar() {
    contadorSegundos--;
    if (contadorSegundos < 0) {
      contadorSegundos = 59;
      contadorMinutos--;
    }

    if (contadorMinutos == 0 && contadorSegundos == 0) {
      pausarTimer();
      String texto = "";
      if (estado == TipoPersonalizado.enfoque) {
        texto = mensajeAleatorio(mensajesDescanso);
      } else {
        texto = mensajeAleatorio(mensajesEnfoque);
      }
      ManejarSonido.reproducir("finish.mp3");
      Vibration.vibrate(
        pattern: [0, 300, 70, 300, 70, 650],
      );
      cambiarEstado();
      elegirEstado();
      contando = false;
    }
    notifyListeners();
  }

  double calcularProgreso() {
    int tiempoTotal;
    switch (estado) {
      case TipoPersonalizado.enfoque:
        tiempoTotal = _config.tiempoEnfoque * 60;
        break;
      case TipoPersonalizado.descanso:
        tiempoTotal = _config.tiempoDescanso * 60;
        break;
      case TipoPersonalizado.descansoLargo:
        tiempoTotal = _config.tiempoDescansoLargo * 60;
        break;
    }

    int tiempoRestante = (contadorMinutos * 60) + contadorSegundos;
    return tiempoRestante / tiempoTotal;
  }

  void pausarReanudar() {
    pulsado = true;
    if (contando) {
      contando = false;
      pausarTimer();
    } else {
      contando = true;
      ManejarSonido.reproducir("start.mp3");
      HapticFeedback.mediumImpact();
      iniciarTimer();
    }

    Future.delayed(Duration(milliseconds: 150), () {
      pulsado = false;
      notifyListeners();
    });
    notifyListeners();
  }

  

  void elegirEstado() {
    contadorSegundos = 0;
    switch (estado) {
      case TipoPersonalizado.enfoque:
        contadorMinutos = _config.tiempoEnfoque;
        textoEstado = "Enfoque";
        break;
      case TipoPersonalizado.descanso:
        contadorMinutos = _config.tiempoDescanso;
        textoEstado = "Descanso";
        break;
      case TipoPersonalizado.descansoLargo:
        contadorMinutos = _config.tiempoDescansoLargo;
        textoEstado = "Descanso largo";
        break;
    }
    notifyListeners();
  }

  void cambiarEstado() {
    switch (estado) {
      case TipoPersonalizado.enfoque:
        if (contadorSesiones >= 4) {
          estado = TipoPersonalizado.descansoLargo;
        } else {
          estado = TipoPersonalizado.descanso;
        }
        break;
      case TipoPersonalizado.descanso:
        estado = TipoPersonalizado.enfoque;
        contadorSesiones++;
        break;
      case TipoPersonalizado.descansoLargo:
        estado = TipoPersonalizado.enfoque;
        contadorSesiones = 1;
        break;
    }
    notifyListeners();
  }
  
  Timer? timerGeneral;

  void iniciarTimer() {
    timerGeneral = Timer.periodic(Duration(seconds: 1), (_) {
      decrementar();
    });
    notifyListeners();
  }

  void pausarTimer() {
    timerGeneral?.cancel();
    notifyListeners();
  }
}