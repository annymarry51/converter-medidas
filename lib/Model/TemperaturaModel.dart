import 'MedidaModel.dart';

class TemperaturaModel extends MedidaModel {
  @override
  String get nome => 'Temperatura';
  @override
  String get unidade => '';
  @override
  set unidade(String valor) => unidade = valor;
  @override
  List<String> get unidades => ['°C', '°F', 'K'];
}
