import 'MedidaModel.dart';

class TemperaturaModel extends MedidaModel {
  @override
  String get nome => 'Temperatura';

  @override
  List<String> get unidades => ['°C', '°F', 'K'];
}
