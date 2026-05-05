import 'package:flutter/material.dart';
import 'tela_inicial.dart';
import 'quiz_prehistoria.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'História App',
      debugShowCheckedModeBanner: false,
      home: const TelaInicial(),
    );
  }
}