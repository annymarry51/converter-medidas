import 'MedidaModel.dart';

class MassaModel extends MedidaModel {
  @override
  String get nome => 'Massa';

  @override
  String get unidade => '';

  @override
  List<String> get unidades => ['kg', 'g', 'mg'];

}
