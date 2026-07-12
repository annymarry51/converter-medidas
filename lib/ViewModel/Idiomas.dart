import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Idiomas extends ChangeNotifier {
  String _idiomaSelecionado = 'pt';

  String get idiomaSelecionado => _idiomaSelecionado;

  Idiomas() {
    _carregarIdioma();
  }

  static const Map<String, Map<String, String>> _traducoes = {
    'pt': {
      'tituloApp': 'Conversor de Unidades',
      'configuracoes': 'Configurações',
      'tema': 'Tema',
      'idioma': 'Idioma',
      'roxo': 'Roxo',
      'azul': 'Azul',
      'verde': 'Verde',
      'temperatura': 'Temperatura',
      'comprimento': 'Comprimento',
      'peso': 'Peso',
      'capacidade': 'Capacidade',
      'valor': 'Valor',
      'converter': 'Converter',
      'erroSelecioneMedida': 'Selecione um tipo de medida',
      'erroSelecioneUnidades': 'Selecione as unidades de origem e destino',
      'erroValorInvalido': 'Digite um valor numérico válido',
      'erroTemperaturaAbsZero': 'Valor abaixo do zero absoluto',
      'erroValorNegativo': 'O valor não pode ser negativo',
    },
    'en': {
      'tituloApp': 'Unit Converter',
      'configuracoes': 'Settings',
      'tema': 'Theme',
      'idioma': 'Language',
      'roxo': 'Purple',
      'azul': 'Blue',
      'verde': 'Green',
      'temperatura': 'Temperature',
      'comprimento': 'Length',
      'peso': 'Weight',
      'capacidade': 'Capacity',
      'valor': 'Value',
      'converter': 'Convert',
      'erroSelecioneMedida': 'Select a measurement type',
      'erroSelecioneUnidades': 'Select the origin and destination units',
      'erroValorInvalido': 'Enter a valid numeric value',
      'erroTemperaturaAbsZero': 'Value below absolute zero',
      'erroValorNegativo': 'Value cannot be negative',
    },
    'es': {
      'tituloApp': 'Conversor de Unidades',
      'configuracoes': 'Configuración',
      'tema': 'Tema',
      'idioma': 'Idioma',
      'roxo': 'Morado',
      'azul': 'Azul',
      'verde': 'Verde',
      'temperatura': 'Temperatura',
      'comprimento': 'Longitud',
      'peso': 'Peso',
      'capacidade': 'Capacidad',
      'valor': 'Valor',
      'converter': 'Convertir',
      'erroSelecioneMedida': 'Selecciona un tipo de medida',
      'erroSelecioneUnidades': 'Selecciona las unidades de origen y destino',
      'erroValorInvalido': 'Ingresa un valor numérico válido',
      'erroTemperaturaAbsZero': 'Valor por debajo del cero absoluto',
      'erroValorNegativo': 'El valor no puede ser negativo',
    },
  };

  /// Retorna o texto traduzido para a [chave] no idioma atual.
  String t(String chave) {
    return _traducoes[_idiomaSelecionado]?[chave] ??
        _traducoes['pt']![chave] ??
        chave;
  }

  void setIdioma(String idioma) {
    _idiomaSelecionado = idioma;
    _salvarIdioma();
    notifyListeners();
  }

  Future<void> _carregarIdioma() async {
    final prefs = await SharedPreferences.getInstance();
    _idiomaSelecionado = prefs.getString('idiomaSelecionado') ?? 'pt';
    notifyListeners();
  }

  Future<void> _salvarIdioma() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idiomaSelecionado', _idiomaSelecionado);
  }
}
