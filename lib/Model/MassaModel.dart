import 'MedidaModel.dart';
class MassaModel extends MedidaModel {
  double massa;

  MassaModel(this.massa) : super();

  @override
  String get nome => 'Massa';

  @override
  List<String> get unidades => ['kg', 'g', 'mg'];
}