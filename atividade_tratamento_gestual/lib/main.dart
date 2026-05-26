import 'package:flutter/material.dart';
import 'package:atividade_tratamento_gestual/cadastro_usuario.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroUsuario(),
      debugShowCheckedModeBanner: false,
    );
  }
}