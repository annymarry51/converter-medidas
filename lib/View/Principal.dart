import 'package:flutter/material.dart';
import 'package:flutter_application_2/View/Configuracoes.dart';
import 'package:flutter_application_2/ViewModel/Conversor.dart';
import '../Model/MedidaModel.dart';
import '../Model/TemperaturaModel.dart';
import '../Model/ComprimentoModel.dart';
import '../Model/MassaModel.dart';
import '../Model/CapacidadeModel.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  MedidaModel? medidaSelecionada;
  String? unidadeOrigem;
  String? unidadeDestino;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Conversor de Unidades'),
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
                construirBotoesCarrossel('Temperatura'),
                construirBotoesCarrossel('Comprimento'),
                construirBotoesCarrossel('Peso'),
                construirBotoesCarrossel('Capacidade'),
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
                      onChanged: (String? novoValor) {
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
                  onPressed: () => print("Inverter!"),
                ),
              ),

              Expanded(
                child: Container(
                  color: const Color(0xFFE6B8E6),
                  child: Center(
                    child: construirCaixinhaConversao(
                      items: medidaSelecionada?.unidades ?? [],
                      selecionado: unidadeDestino,
                      onChanged: (String? novoValor) {
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
                    print('Botão de conversão pressionado');
                  },
                  child: const Text(
                    'Converter',
                    style: TextStyle(fontSize: 24, color: Color(0xFFE6B8E6)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container construirBotoesCarrossel(String texto) {
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
            switch (texto) {
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
          });
        },
        child: Text(
          texto,
          style: const TextStyle(fontSize: 24, color: Color(0xFFE6B8E6)),
        ),
      ),
    );
  }

  Widget construirCaixinhaConversao<T extends MedidaModel>({
    required List<String> items,
    required String? selecionado,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
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
        ),
      ],
    );
  }
}
