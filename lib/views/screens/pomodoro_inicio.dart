import 'package:app_prob_pomodoro/i18n/strings.g.dart';
import 'package:app_prob_pomodoro/view_models/pomodoro_provider.dart';
import 'package:app_prob_pomodoro/views/screens/panel_opciones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/circulo_reloj.dart' show CirculoReloj;
import '../widgets/boton_base.dart';


//import '../utils/Alertas.dart';

class PomodoroInicio extends StatefulWidget {
  @override
  State<PomodoroInicio> createState() => _PomodoroInicioState();
}

class _PomodoroInicioState extends State<PomodoroInicio> {

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;

    final provider = context.watch<PomodoroProvider>();

    return Scaffold(
        backgroundColor: Colors.yellow[50],
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 730),
                    curve: Curves.easeInOut,
                    height: provider.contando ? alto * 0.01 : alto * 0.12,
                  ),
                  Text(
                    provider.textoEstado,
                    style: TextStyle(
                      fontSize: ancho * 0.11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 730),
                    curve: Curves.easeInOut,
                    height: alto * 0.04,
                  ),
                  CirculoReloj(
                    pulsado: provider.pulsado,
                    calcularProgreso: provider.calcularProgreso(),
                    pausarReanudar: () =>
                    context
                      .read<PomodoroProvider>()
                      .pausarReanudar(),
                    contadorMinutos: provider.contadorMinutos,
                    contadorSegundos: provider.contadorSegundos,
                    contando: provider.contando,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 730),
                    curve: Curves.easeInOut,
                    height: alto * 0.07,
                  ),
                  AnimatedOpacity(
                    opacity: provider.contando ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 600),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 730),
                      curve: Curves.easeInOut,
                      height: provider.contando ? 0 : alto * 0.05,
                      child: Text(
                        "${t.timer.session} ${provider.contadorSesiones}/4",
                        style: TextStyle(
                          fontSize: ancho * 0.071,
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: provider.contando ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 600),
                    child: IgnorePointer(
                      ignoring: provider.contando,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 730),
                        curve: Curves.easeInOut,
                        height: provider.contando ? 0 : alto * 0.22,
                        child: Column(
                          children: [
                            SizedBox(height: alto * 0.04),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 730),
                              curve: Curves.easeInOut,
                              height: alto * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BotonBase(
                                    funcion: context
                                      .read<PomodoroProvider>()
                                      .ejecutarReinicio,
                                    icono: Icons.refresh,
                                    texto: t.timer.reset),
                                SizedBox(width: ancho * 0.04),
                                BotonBase(
                                    funcion: context
                                      .read<PomodoroProvider>()
                                      .saltarSeccion,
                                    icono: Icons
                                        .keyboard_double_arrow_right_outlined,
                                    texto: t.timer.skip),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: alto * 0.073,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ancho * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  AnimatedOpacity(
                    opacity: provider.contando ? 0.0 : 1, 
                    duration: Duration(milliseconds: 600),
                    child: IgnorePointer(
                      ignoring: provider.contando,
                      child: PopupMenuButton<AppLocale>(
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.blue[200]!, width: 1.5)
                      ),
                      color: Colors.yellow[50],
                      elevation: 2,
                      // 1. Lo que se muestra cuando el menú está cerrado
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[500]!, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          LocaleSettings.currentLocale.languageCode.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange[300]),
                        ),
                      ),
                      // 2. La lógica al seleccionar una opción
                      onSelected: (AppLocale newLocale) {
                        LocaleSettings.setLocale(newLocale);
                        provider.setIdioma(idioma: newLocale.languageCode);
                      },
                      // 3. Las opciones que aparecen al tocarlo
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: AppLocale.en,
                          child: Text("EN - English", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 15),),
                        ),
                        PopupMenuItem(
                          value: AppLocale.es,
                          child: Text("ES - Español", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 15),),
                        ),
                      ],
                    ),
                    )
                  ),
                  AnimatedOpacity(
                    opacity: provider.contando ? 0.0 : 1, 
                    duration: Duration(milliseconds: 600),
                    child: IgnorePointer(
                      ignoring: provider.contando,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings, 
                          color: Colors.deepOrange[300],
                          size: 32,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            useSafeArea: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              )
                            ),
                            backgroundColor: Colors.yellow[50],
                            builder: (context){
                              return PanelOpciones();
                            }
                          );
                        },
                      ),
                    )
                    ),
                  ],
                ),
              )
            )
          ],
        ));
  }
}
