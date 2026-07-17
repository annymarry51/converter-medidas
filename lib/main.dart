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
          theme: obterTema(
            prefs.temaSelecionado,
          ), 
          home: Principal(),
        );
      },
    );
  }

  ThemeData obterTema(String temaSelecionado) {
    switch (temaSelecionado) {
      case 'Azul':
        return ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 160, 208, 248),
         colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 81, 117, 246),
          secondary: const Color.fromARGB(255, 137, 225, 239),
        ),);
      case 'Verde':
        return ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 148, 245, 151),
         colorScheme: ColorScheme.light(
          primary: Colors.green.shade700,
          secondary: Colors.green.shade300,
        ),);
      default:
        return ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 205, 68, 247),
         colorScheme: ColorScheme.light(
          primary: Color(0xFFE6B8E6),
          secondary: Color.fromARGB(255, 121, 1, 157),
        ),);
    }
  }
}
