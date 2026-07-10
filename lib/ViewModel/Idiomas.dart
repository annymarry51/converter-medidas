import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Idiomas extends ChangeNotifier {
  String _idiomaSelecionado = 'pt';

  String get idiomaSelecionado => _idiomaSelecionado;

  void setIdioma(String idioma) {
    _idiomaSelecionado = idioma;
    notifyListeners();
  }
}