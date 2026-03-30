import 'package:flutter/material.dart';

class MinutosProvider extends ChangeNotifier {

  int minutoPersonalizado;

  MinutosProvider({
    this.minutoPersonalizado = 25,
  });

  void guardarPersonalizado ({required int num}) {
    minutoPersonalizado = num;
    notifyListeners();
  }

}