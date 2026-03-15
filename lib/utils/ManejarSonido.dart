import 'package:audioplayers/audioplayers.dart';


class ManejarSonido {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> reproducir(String archivo) async {
    try{
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource("sounds/$archivo"));
    }catch(e){
      print("Error: $e");
    }
  }

  static Future<void> detener() async{
    _audioPlayer.stop();
  }

  static Future<void> pausar() async{
    _audioPlayer.pause();
  }

  static Future<void> continuar() async{
    _audioPlayer.resume();
  }

  static Future<void> dispose() async{
    _audioPlayer.dispose();
  }
} 

  