import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Preferencias extends ChangeNotifier {
   String temaSelecionado = 'Roxo';

  Preferencias() {
    _loadPreferences();
  }

  void mudarTema(String novoTema) {
     temaSelecionado = novoTema;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    temaSelecionado = prefs.getString('temaSelecionado') ?? 'Roxo';
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temaSelecionado', temaSelecionado);
  }

}