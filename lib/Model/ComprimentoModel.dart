import 'MedidaModel.dart';
class ComprimentoModel extends MedidaModel {
  @override
  String get nome => 'Comprimento';

  @override
  List<String> get unidades => ['m', 'cm', 'mm'];
}