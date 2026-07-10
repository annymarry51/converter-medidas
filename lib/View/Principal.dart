import 'package:flutter/material.dart';
import 'package:flutter_application_2/View/Configuracoes.dart';
import '../Model/MedidaModel.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
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
        ]
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
                    child: construirCaixinhaConversao<MedidaModel>(
                      items: [],
                      selecionado: null,
                      onChanged: (MedidaModel? novoValor) {
                        setState(() {});
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
                    child: construirCaixinhaConversao<MedidaModel>(
                      items: [],
                      selecionado: null,
                      onChanged: (MedidaModel? novoValor) {
                        setState(() {
                          // Atualize o estado com o novo valor selecionado
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
            Center(child: 
            Container(
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
          print('Botão $texto pressionado');
        },
        child: Text(
          texto,
          style: const TextStyle(fontSize: 24, color: Color(0xFFE6B8E6)),
        ),
      ),
    );
  }

  Widget construirCaixinhaConversao<T extends MedidaModel>({
    required List<T> items,
    required T? selecionado,
    required ValueChanged<T?> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: DropdownButton<T>(
              isExpanded: true,
              value: selecionado,
              underline: Container(height: 1, color: Colors.amber),
              items: items
                  .map(
                    (e) => DropdownMenuItem<T>(value: e, child: Text(e.nome)),
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
