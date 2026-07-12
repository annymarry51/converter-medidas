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
  MedidaModel? medidaSelecionada;
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 80,
            child: PageView(
              controller: PageController(viewportFraction: 0.35),
              children: [
                construirBotoesCarrossel('Temperatura', idiomas.t('temperatura')),
                construirBotoesCarrossel('Comprimento', idiomas.t('comprimento')),
                construirBotoesCarrossel('Peso', idiomas.t('peso')),
                construirBotoesCarrossel('Capacidade', idiomas.t('capacidade')),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFE6B8E6),
                  child: Center(
                    child: construirCaixinhaConversao(
                      items: medidaSelecionada?.unidades ?? [],
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
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade700,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.compare_arrows, color: Colors.white),
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

              Expanded(
                child: Container(
                  color: const Color(0xFFE6B8E6),
                  child: Center(
                    child: construirCaixinhaConversao(
                      items: medidaSelecionada?.unidades ?? [],
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
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.purple.shade900,
        child: Row(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF744383),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    final erro = validarEntrada(idiomas);
                    if (erro != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(erro)),
                      );
                      return;
                    }

                    final valor = double.parse(
                      origemController.text.replaceAll(',', '.'),
                    );

                    final resultado = conversor.converter(
                      medidaSelecionada!,
                      valor,
                      unidadeOrigem!,
                      unidadeDestino!,
                    );

                    setState(() {
                      destinoController.text = resultado.toStringAsFixed(6);
                    });
                  },
                  child: Text(
                    idiomas.t('converter'),
                    style: const TextStyle(fontSize: 24, color: Color(0xFFE6B8E6)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Valida os campos antes de converter.
  /// Retorna a mensagem de erro traduzida, ou `null` se estiver tudo certo.
  String? validarEntrada(Idiomas idiomas) {
    if (medidaSelecionada == null) {
      return idiomas.t('erroSelecioneMedida');
    }
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

  Container construirBotoesCarrossel(String chave, String rotulo) {
    return Container(
      height: 50,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF744383),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          setState(() {
            switch (chave) {
              case 'Temperatura':
                medidaSelecionada = TemperaturaModel();
                break;
              case 'Comprimento':
                medidaSelecionada = ComprimentoModel();
                break;
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
        child: Text(
          rotulo,
          style: const TextStyle(fontSize: 24, color: Color(0xFFE6B8E6)),
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
          width: 100,
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
        const SizedBox(width: 8),
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
