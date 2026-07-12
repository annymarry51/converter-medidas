import 'package:flutter/material.dart';
import 'package:flutter_application_2/ViewModel/Preferencias.dart';
import 'package:flutter_application_2/ViewModel/Idiomas.dart';
import 'package:provider/provider.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<Preferencias>(context);
    final idiomas = Provider.of<Idiomas>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(idiomas.t('configuracoes')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(idiomas.t('tema')),
          botaoTema('Roxo', idiomas.t('roxo'), prefs),
          botaoTema('Azul', idiomas.t('azul'), prefs),
          botaoTema('Verde', idiomas.t('verde'), prefs),
          const SizedBox(height: 24),
          Text(idiomas.t('idioma')),
          botaoIdioma('pt', 'Português', idiomas),
          botaoIdioma('en', 'English', idiomas),
          botaoIdioma('es', 'Español', idiomas),
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

  Widget botaoIdioma(String valor, String rotulo, Idiomas idiomas) {
    return RadioListTile<String>(
      title: Text(rotulo),
      value: valor,
      groupValue: idiomas.idiomaSelecionado,
      onChanged: (String? novoValor) {
        if (novoValor != null) {
          idiomas.setIdioma(novoValor);
        }
      },
    );
  }
}
