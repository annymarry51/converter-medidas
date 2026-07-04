import 'MedidaModel.dart';
class TemperaturaModel extends MedidaModel {
  double temperatura;

  TemperaturaModel(this.temperatura) : super();

  @override
  String get nome => 'Temperatura';

  @override
  List<String> get unidades => ['°C', '°F', 'K'];
}