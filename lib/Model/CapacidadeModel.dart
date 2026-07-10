import 'MedidaModel.dart';

class CapacidadeModel extends MedidaModel {
  @override
  String get nome => 'Capacidade';

  @override
  String get unidade => '';
  @override
  set unidade(String valor) => unidade = valor;
  @override
  List<String> get unidades => ['L', 'mL', 'm³'];
}
