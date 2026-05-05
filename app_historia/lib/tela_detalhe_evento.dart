import 'package:flutter/material.dart';

class TelaDetalheEvento extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String ano;

  const TelaDetalheEvento({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.ano,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ano,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              titulo,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Text(
              descricao,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}