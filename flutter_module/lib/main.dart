import 'package:first_module/main.dart';
import 'package:flutter/material.dart';
import "package:second_module/main.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(routes: {
    '/': (context) {
      //for not showing empty screen for every exit
      Navigator.pop(context);
      return const Scaffold();
    },
    '/firstModule': (context) => const FirstModuleApp(),
    '/secondModule': (context) => const SecondModuleApp(),
  }));
}

@pragma('vm:entry-point')
void firstModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: FirstModuleApp()));
}

@pragma('vm:entry-point')
void secondModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: SecondModuleApp()));
}
