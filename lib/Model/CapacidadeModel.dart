import 'MedidaModel.dart';

class CapacidadeModel extends MedidaModel {
  double capacidade;
  CapacidadeModel([this.capacidade = 0]) : super();

  @override
  String get nome => 'Capacidade';

  @override
  List<String> get unidades => ['L', 'mL', 'm³'];

  static const Map<String, double> _fatorParaLitro = {
    'L': 1.0,
    'mL': 0.001,
    'm³': 1000.0,
  };

  @override
  double converter(double valor, String deUnidade, String paraUnidade) {
    if (deUnidade == paraUnidade) return valor;
    final emLitros = valor * _fatorParaLitro[deUnidade]!;
    return emLitros / _fatorParaLitro[paraUnidade]!;
  }
}
