import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> inicializar() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);

    // Pedir permiso en Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation
          <AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> mostrarFinSesion(String titulo, String cuerpo) async {
    const detalles = AndroidNotificationDetails(
      'pomodoro_fin',
      'Fin de sesión',
      channelDescription: 'Aviso cuando termina el pomodoro',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    await _plugin.show(
      0,
      titulo,
      cuerpo,
      NotificationDetails(android: detalles),
    );
  }

  static Future<void> cancelar() async {
    await _plugin.cancelAll();
  }

  static Future<void> mostrarContando(String tiempo) async {
    const detalles = AndroidNotificationDetails(
      'pomodoro_corriendo',
      'Timer activo',
      channelDescription: 'Muestra el tiempo mientras corre',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: false,
      autoCancel: true,
      playSound: false,
      enableVibration: false,
    );

    await _plugin.show(
      1,
      'Pomodoro corriendo',
      tiempo,
      NotificationDetails(android: detalles),
    );
  }
}