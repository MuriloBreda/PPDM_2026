import 'package:flutter/material.dart';

class TelaExemploLogica extends StatefulWidget {
  const TelaExemploLogica({super.key});

  @override
  State<TelaExemploLogica> createState() => _TelaExemploLogicaState();
}

class _TelaExemploLogicaState extends State<TelaExemploLogica> {

  final TextEditingController _controller = TextEditingController();
  String resultado = "";

  void processar() {
    String texto = _controller.text;

    
    if (texto.isEmpty) {
      resultado = "Digite um acontecimento histórico!";
    } else {
      resultado = "Acontecimento: $texto";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acontecimento Histórico")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Um acontecimento histórico...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: processar,
              child: const Text("Escrever..."),
            ),

            const SizedBox(height: 20),

            Text(
              resultado,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}