
abstract class MedidaModel {
  String get nome;
  
    List<String> get unidades;

  double converter(double valor, String deUnidade, String paraUnidade);
}
