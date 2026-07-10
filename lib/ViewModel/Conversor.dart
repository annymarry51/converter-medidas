import 'package:flutter/material.dart';
import '../Model/MedidaModel.dart';
import '../Model/TemperaturaModel.dart';
import '../Model/ComprimentoModel.dart';
import '../Model/MassaModel.dart';
import '../Model/CapacidadeModel.dart';

class Conversor extends ChangeNotifier {
  MedidaModel? para;
  MedidaModel? de;

double converter( MedidaModel medida, double valor, String deUnidade, String paraUnidade) {
  if (medida is TemperaturaModel) {
    return converterTemperatura(valor, deUnidade, paraUnidade);
  } else if (medida is ComprimentoModel) {
    return converterComprimento(valor, deUnidade, paraUnidade);
  } else if (medida is MassaModel) {
    return converterMassa(valor, deUnidade, paraUnidade);
  } else if (medida is CapacidadeModel) {
    return converterCapacidade(valor, deUnidade, paraUnidade);
  }

  return valor;
}
  double converterTemperatura(double valor, String deTemp, String paraTemp) {
    double resultado = 0.0;

    if ((deTemp == '°C') && (paraTemp == '°F')) {
      resultado = (valor * 9 / 5) + 32;
    } else if ((deTemp == '°F') && (paraTemp == '°C')) {
      resultado = (valor - 32) * 5 / 9;
    } else if ((deTemp == '°C') && (paraTemp == 'K')) {
      resultado = valor + 273.15;
    } else if ((deTemp == 'K') && (paraTemp == '°C')) {
      resultado = valor - 273.15;
    } else if ((deTemp == '°F') && (paraTemp == 'K')) {
      resultado = (valor - 32) * 5 / 9 + 273.15;
    } else if ((deTemp == 'K') && (paraTemp == '°F')) {
      resultado = (valor - 273.15) * 9 / 5 + 32;
    } else {
      resultado = valor;
    }

    return resultado;
  }

  double converterComprimento(double valor, String deComp, String paraComp) {
    double resultado = 0.0;

    if ((deComp == 'm') && (paraComp == 'cm')) {
      resultado = valor * 100;
    } else if ((deComp == 'cm') && (paraComp == 'm')) {
      resultado = valor / 100;
    } else if ((deComp == 'm') && (paraComp == 'mm')) {
      resultado = valor * 1000;
    } else if ((deComp == 'mm') && (paraComp == 'm')) {
      resultado = valor / 1000;
    } else if ((deComp == 'cm') && (paraComp == 'mm')) {
      resultado = valor * 10;
    } else if ((deComp == 'mm') && (paraComp == 'cm')) {
      resultado = valor / 10;
    } else {
      resultado = valor;
    }

    return resultado;
  }

  double converterMassa(double valor, String deMassa, String paraMassa) {
    double resultado = 0.0;

    if ((deMassa == 'kg') && (paraMassa == 'g')) {
      resultado = valor * 1000;
    } else if ((deMassa == 'g') && (paraMassa == 'kg')) {
      resultado = valor / 1000;
    } else if ((deMassa == 'kg') && (paraMassa == 'mg')) {
      resultado = valor * 1000000;
    } else if ((deMassa == 'mg') && (paraMassa == 'kg')) {
      resultado = valor / 1000000;
    } else if ((deMassa == 'g') && (paraMassa == 'mg')) {
      resultado = valor * 1000;
    } else if ((deMassa == 'mg') && (paraMassa == 'g')) {
      resultado = valor / 1000;
    } else {
      resultado = valor;
    }

    return resultado;
  }

  double converterCapacidade(
    double valor,
    String deCapacidade,
    String paraCapacidade,
  ) {
    double resultado = 0.0;

    if ((deCapacidade == 'L') && (paraCapacidade == 'mL')) {
      resultado = valor * 1000;
    } else if ((deCapacidade == 'mL') && (paraCapacidade == 'L')) {
      resultado = valor / 1000;
    } else if ((deCapacidade == 'L') && (paraCapacidade == 'm³')) {
      resultado = valor / 1000;
    } else if ((deCapacidade == 'm³') && (paraCapacidade == 'L')) {
      resultado = valor * 1000;
    } else if ((deCapacidade == 'mL') && (paraCapacidade == 'm³')) {
      resultado = valor / 1000000;
    } else if ((deCapacidade == 'm³') && (paraCapacidade == 'mL')) {
      resultado = valor * 1000000;
    } else {
      resultado = valor;
    }

    return resultado;
  }
}
