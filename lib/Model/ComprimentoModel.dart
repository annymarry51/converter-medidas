import 'MedidaModel.dart';
class ComprimentoModel extends MedidaModel {
  double comprimento;

  ComprimentoModel(this.comprimento) : super();

  @override
  String get nome => 'Comprimento';

  @override
  List<String> get unidades => ['m', 'cm', 'mm'];
}