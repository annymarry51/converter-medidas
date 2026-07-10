import 'package:flutter/material.dart';
import 'package:flutter_application_2/ViewModel/Preferencias.dart';
import 'package:provider/provider.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();

}

class _ConfiguracoesState extends State<Configuracoes> {


  @override
  Widget build(BuildContext context) {
  final prefs = Provider.of<Preferencias>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tema'),
          botaoTema('Roxo', 'Roxo', prefs),
          botaoTema('Azul', 'Azul', prefs),
          botaoTema('Verde', 'Verde', prefs),
        ],
      ),
    );
  }

Widget botaoTema(String valor, String rotulo, Preferencias prefs) {
    return RadioListTile<String>(
      title: Text(rotulo),
      value: valor,
      groupValue: prefs.temaSelecionado, 
      onChanged: (String? novoValor) {
        if (novoValor != null) {
          prefs.mudarTema(novoValor); 
        }
      },
    );
  }
}  
