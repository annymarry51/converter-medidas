import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:provider/provider.dart';
import 'ViewModel/Conversor.dart';
import 'View/principal.dart';

void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Conversor(),
      child: MaterialApp(theme: ThemeData.dark(), home: Principal()),
    );
  }
}
