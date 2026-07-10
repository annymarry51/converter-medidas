import 'MedidaModel.dart';

class MassaModel extends MedidaModel {
  double massa;
  MassaModel([this.massa = 0]) : super();

  @override
  String get nome => 'Massa';

  @override
  List<String> get unidades => ['kg', 'g', 'mg'];

  static const Map<String, double> _fatorParaGrama = {
    'kg': 1000.0,
    'g': 1.0,
    'mg': 0.001,
  };

  @override
  double converter(double valor, String deUnidade, String paraUnidade) {
    if (deUnidade == paraUnidade) return valor;
    final emGramas = valor * _fatorParaGrama[deUnidade]!;
    return emGramas / _fatorParaGrama[paraUnidade]!;
  }
}
