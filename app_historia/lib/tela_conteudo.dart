import 'package:flutter/material.dart';


class TelaConteudo extends StatelessWidget {
  final String titulo;

  const TelaConteudo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    
    // MUDAR OS DETALHES DO CONTEÚDO AQUI
    children: [
      Text(
        "Conteúdo de $titulo",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      const Text(
        "Descrição breve de cada acontecimento",
        style: TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 20),
      
    ],
  ),
),
    );
  }
}