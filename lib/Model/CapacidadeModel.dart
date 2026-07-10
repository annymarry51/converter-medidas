import 'MedidaModel.dart';

class CapacidadeModel extends MedidaModel {
  @override
  String get nome => 'Capacidade';

  @override
  List<String> get unidades => ['L', 'mL', 'm³'];
}
