import 'MedidaModel.dart';

class TemperaturaModel extends MedidaModel {
  double temperatura;
  TemperaturaModel([this.temperatura = 0]) : super();

  @override
  String get nome => 'Temperatura';

  @override
  List<String> get unidades => ['°C', '°F', 'K'];

  @override
  double converter(double valor, String deUnidade, String paraUnidade) {
    if (deUnidade == paraUnidade) return valor;

    // Passo 1: converte a unidade de origem para Celsius (base)
    double celsius;
    switch (deUnidade) {
      case '°F':
        celsius = (valor - 32) * 5 / 9;
        break;
      case 'K':
        celsius = valor - 273.15;
        break;
      default: // °C
        celsius = valor;
    }

    // Passo 2: converte de Celsius para a unidade de destino
    switch (paraUnidade) {
      case '°F':
        return (celsius * 9 / 5) + 32;
      case 'K':
        return celsius + 273.15;
      default: // °C
        return celsius;
    }
  }
}
