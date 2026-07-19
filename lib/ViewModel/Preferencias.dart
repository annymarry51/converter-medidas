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

  ThemeData obterTema(String temaSelecionado) {
    switch (temaSelecionado) {
      case 'Azul':
        return ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
         colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 130, 155, 247),
          secondary: const Color.fromARGB(255, 45, 107, 240),
        ),);
      case 'Verde':
        return ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
         colorScheme: ColorScheme.light(
          primary: Colors.green.shade300,
          secondary: Colors.green.shade700,
        ),);
      default:
        return ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
         colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 203, 143, 240),
          secondary: Color.fromARGB(255, 121, 1, 157),
        ),);
    }
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