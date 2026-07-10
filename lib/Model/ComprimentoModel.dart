import 'MedidaModel.dart';
class ComprimentoModel extends MedidaModel {
  @override
  String get nome => 'Comprimento';

  @override
  String get unidade => '';

  @override
  set unidade(String valor) => unidade = valor;

  @override
  List<String> get unidades => ['m', 'cm', 'mm'];
}