import 'package:flutter/material.dart';
import 'package:flutter_application_2/View/Configuracoes.dart';
import 'package:flutter_application_2/ViewModel/Idiomas.dart';
import 'package:provider/provider.dart';
import '../Model/MedidaModel.dart';
import '../Model/TemperaturaModel.dart';
import '../Model/ComprimentoModel.dart';
import '../Model/MassaModel.dart';
import '../Model/CapacidadeModel.dart';
import '../ViewModel/Conversor.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final TextEditingController origemController = TextEditingController();
  final TextEditingController destinoController = TextEditingController();

  final Conversor conversor = Conversor();
  MedidaModel medidaSelecionada = TemperaturaModel();
  String? unidadeOrigem;
  String? unidadeDestino;
  double? valorOrigem;

  @override
  Widget build(BuildContext context) {
    final idiomas = Provider.of<Idiomas>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(idiomas.t('tituloApp')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Configuracoes()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 80,
              child: selecionarMedida(
                selecionado: medidaSelecionada.nome,
                onChanged: (String? value) {
                  if (value == null) return;
                  setState(() {
                    switch (value) {
                      case 'Temperatura':
                        medidaSelecionada = TemperaturaModel();
                        break;
                      case 'Comprimento':
                        medidaSelecionada = ComprimentoModel();
                        break;
                      case 'Massa':
                      case 'Peso':
                        medidaSelecionada = MassaModel();
                        break;
                      case 'Capacidade':
                        medidaSelecionada = CapacidadeModel();
                        break;
                    }
                    unidadeOrigem = null;
                    unidadeDestino = null;
                    origemController.clear();
                    destinoController.clear();
                  });
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: construirCaixinhaConversao(
                      items: medidaSelecionada.unidades,
                      selecionado: unidadeOrigem,
                      controller: origemController,
                      onChanged: (novoValor) {
                        setState(() {
                          unidadeOrigem = novoValor;
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.compare_arrows,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (unidadeOrigem == null || unidadeDestino == null) {
                          return;
                        }
                        setState(() {
                          final unidadeTemp = unidadeOrigem;
                          unidadeOrigem = unidadeDestino;
                          unidadeDestino = unidadeTemp;

                          final valorTemp = origemController.text;
                          origemController.text = destinoController.text;
                          destinoController.text = valorTemp;
                        });
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: construirCaixinhaConversao(
                      items: medidaSelecionada.unidades,
                      selecionado: unidadeDestino,
                      controller: destinoController,
                      somenteLeitura: true,
                      onChanged: (novoValor) {
                        setState(() {
                          unidadeDestino = novoValor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              final erro = validarEntrada(idiomas);
              if (erro != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(erro)));
                return;
              }

              final valor = double.parse(
                origemController.text.replaceAll(',', '.'),
              );

              final resultado = conversor.converter(
                medidaSelecionada,
                valor,
                unidadeOrigem!,
                unidadeDestino!,
              );

              setState(() {
                destinoController.text = resultado.toString();
              });
            },
            child: Text(
              idiomas.t('converter'),
              style: const TextStyle(fontSize: 24, color: Color.fromARGB(255, 252, 250, 252)),
            ),
          ),
        ),
      ),
    );
  }

  /// Valida os campos antes de converter.
  /// Retorna a mensagem de erro traduzida, ou `null` se estiver tudo certo.
  String? validarEntrada(Idiomas idiomas) {
    if (unidadeOrigem == null || unidadeDestino == null) {
      return idiomas.t('erroSelecioneUnidades');
    }
    final texto = origemController.text.trim().replaceAll(',', '.');
    final valor = double.tryParse(texto);
    if (texto.isEmpty || valor == null) {
      return idiomas.t('erroValorInvalido');
    }

    if (medidaSelecionada is TemperaturaModel) {
      final limiteMinimo = unidadeOrigem == 'K'
          ? 0.0
          : unidadeOrigem == '°F'
          ? -459.67
          : -273.15;
      if (valor < limiteMinimo) {
        return idiomas.t('erroTemperaturaAbsZero');
      }
    } else if (valor < 0) {
      return idiomas.t('erroValorNegativo');
    }

    return null;
  }

  Widget selecionarMedida({
    required String selecionado,
    required ValueChanged<String?> onChanged,
  }) {
    final idiomas = Provider.of<Idiomas>(context);

    List<Map<String, String>> items = [
      {"key": "Capacidade", "label": idiomas.t("capacidade")},
      {"key": "Comprimento", "label": idiomas.t("comprimento")},
      {"key": "Massa", "label": idiomas.t("massa")},
      {"key": "Temperatura", "label": idiomas.t("temperatura")},
    ];
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          value: selecionado,
          isExpanded: true,
          items: items
              .map(
                (unidade) => DropdownMenuItem(
                  value: unidade["key"],
                  child: Text(unidade["label"] ?? ""),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget construirCaixinhaConversao({
    required List<String> items,
    required String? selecionado,
    required ValueChanged<String?> onChanged,
    required TextEditingController controller,
    bool somenteLeitura = false,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: TextField(
            controller: controller,
            readOnly: somenteLeitura,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: Provider.of<Idiomas>(context).t('valor'),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: DropdownButton<String>(
            value: selecionado,
            isExpanded: true,
            items: items
                .map(
                  (unidade) =>
                      DropdownMenuItem(value: unidade, child: Text(unidade)),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
