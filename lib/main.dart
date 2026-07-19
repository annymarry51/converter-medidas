import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter_application_2/ViewModel/Preferencias.dart';
import 'package:flutter_application_2/ViewModel/Idiomas.dart';
import 'package:provider/provider.dart';
import 'ViewModel/Conversor.dart';
import 'View/principal.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Conversor()),
        ChangeNotifierProvider(create: (_) => Preferencias()),
        ChangeNotifierProvider(create: (_) => Idiomas()),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferencias = Provider.of<Preferencias>(context);
    return Consumer<Preferencias>(
      builder: (context, prefs, child) {
        return MaterialApp(
          theme:preferencias.obterTema(
            prefs.temaSelecionado,
          ), 
          home: Principal(),
        );
      },
    );
  }
}
