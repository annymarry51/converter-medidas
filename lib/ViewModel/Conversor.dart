import 'package:flutter/material.dart';
import '../Model/MedidaModel.dart';
import '../Model/TemperaturaModel.dart';
import '../Model/ComprimentoModel.dart';
import '../Model/MassaModel.dart';
import '../Model/CapacidadeModel.dart';

class Conversor extends ChangeNotifier {
  final TextEditingController fromText = TextEditingController();
  final TextEditingController toText = TextEditingController();

  // Ordem alinhada com os botões do carrossel na tela principal
  final List<MedidaModel> categorias = [
    TemperaturaModel(),
    ComprimentoModel(),
    MassaModel(),
    CapacidadeModel(),
  ];

  late MedidaModel categoriaSelecionada;
  String? unidadeDe;
  String? unidadePara;

  Conversor() {
    selecionarCategoria(categorias.first);
  }

  void selecionarCategoria(MedidaModel categoria) {
    categoriaSelecionada = categoria;
    unidadeDe = categoria.unidades.first;
    unidadePara = categoria.unidades.length > 1
        ? categoria.unidades[1]
        : categoria.unidades.first;
    fromText.clear();
    toText.clear();
    notifyListeners();
  }

  void selecionarUnidadeDe(String unidade) {
    unidadeDe = unidade;
    notifyListeners();
  }

  void selecionarUnidadePara(String unidade) {
    unidadePara = unidade;
    notifyListeners();
  }

  void inverterUnidades() {
    final unidadeTemp = unidadeDe;
    unidadeDe = unidadePara;
    unidadePara = unidadeTemp;

    final textoTemp = fromText.text;
    fromText.text = toText.text;
    toText.text = textoTemp;

    notifyListeners();
  }

  void converter() {
    if (unidadeDe == null || unidadePara == null) return;

    final valor = double.tryParse(fromText.text.replaceAll(',', '.'));
    if (valor == null) {
      toText.text = '';
      notifyListeners();
      return;
    }

    final resultado = categoriaSelecionada.converter(
      valor,
      unidadeDe!,
      unidadePara!,
    );
    toText.text = _formatar(resultado);
    notifyListeners();
  }

  String _formatar(double valor) {
    if (valor == valor.roundToDouble()) {
      return valor.toStringAsFixed(0);
    }
    return valor.toStringAsFixed(4);
  }

  @override
  void dispose() {
    fromText.dispose();
    toText.dispose();
    super.dispose();
  }
}
