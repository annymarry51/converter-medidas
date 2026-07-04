import 'MedidaModel.dart';

class CapacidadeModel extends MedidaModel {
  double capacidade;

  CapacidadeModel(this.capacidade) : super();

  @override
  String get nome => 'Capacidade';

  @override
  List<String> get unidades => ['L', 'mL', 'm³'];
}
