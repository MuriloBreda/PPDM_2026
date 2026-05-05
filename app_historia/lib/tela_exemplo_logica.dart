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
      resultado = "⚠️ Digite um acontecimento histórico!";
    } else {
      resultado = "📜 Acontecimento registrado:\n$texto";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Acontecimento Histórico"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.brown, Colors.brown],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "Escreva um acontecimento histórico",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// INPUT
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Ex: Independência do Brasil em 1822...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// BOTÃO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: processar,
                label: const Text(
                  "Registrar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// RESULTADO
            if (resultado.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  resultado,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}