import 'package:flutter/material.dart';
import 'tela_detalhe_evento.dart';

class TelaLinhaDoTempo extends StatelessWidget {
  const TelaLinhaDoTempo({super.key});

  @override
  Widget build(BuildContext context) {
    final eventos = [
      {
      'ano': '4000 a.C.',
      'titulo': 'Invenção da Escrita',
      'descricao': 'Surgimento da escrita cuneiforme na Mesopotâmia, marcando o fim da Pré-História.',
      },
      {
        'ano': '753 a.C.',
        'titulo': 'Fundação de Roma',
        'descricao': 'Início de uma das civilizações mais influentes da Antiguidade.',
      },
      {
        'ano': '476',
        'titulo': 'Queda de Roma',
        'descricao': 'Ocupação de Roma pelos povos germânicos e início da Idade Média.',
      },
      {
        'ano': '1095',
        'titulo': 'As Cruzadas',
        'descricao': 'Expedições militares cristãs rumo à Terra Santa contra o domínio muçulmano.',
      },
      {
        'ano': '1453',
        'titulo': 'Queda de Constantinopla',
        'descricao': 'Tomada da cidade pelos turcos-otomanos, marcando o início da Idade Moderna.',
      },
      {
        'ano': '1492',
        'titulo': 'Chegada à América',
        'descricao': 'Cristóvão Colombo chega ao "Novo Mundo", iniciando a era das Grandes Navegações.',
      },
      {
        'ano': '1760',
        'titulo': 'Revolução Industrial',
        'descricao': 'Início da mecanização da produção na Inglaterra, mudando a economia global.',
      },
      {
        'ano': '1789',
        'titulo': 'Revolução Francesa',
        'descricao': 'Queda da Bastilha e o início da luta contra a monarquia absolutista.',
      },
      {
        'ano': '1914',
        'titulo': 'Primeira Guerra Mundial',
        'descricao': 'Início do conflito global que redesenhou as fronteiras da Europa.',
      },
      {
        'ano': '1939',
        'titulo': 'Segunda Guerra Mundial',
        'descricao': 'Invasão da Polônia e o início do maior conflito armado da história.',
      },
      {
        'ano': '1969',
        'titulo': 'Homem na Lua',
        'descricao': 'Ápice da corrida espacial durante a Guerra Fria com a missão Apollo 11.',
      },
      {
        'ano': '1989',
        'titulo': 'Queda do Muro de Berlim',
        'descricao': 'Símbolo do fim da Guerra Fria e da reunificação da Alemanha.',
      },
      {
        'ano': '1991',
        'titulo': 'Criação da World Wide Web',
        'descricao': 'Tim Berners-Lee libera o código da rede mundial, dando início à Era Digital.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Linha do Tempo")),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(evento['ano']!.substring(0, 2)),
              ),
              title: Text(evento['titulo']!),
              subtitle: Text("Ano: ${evento['ano']}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TelaDetalheEvento(
                      titulo: evento['titulo']!,
                      descricao: evento['descricao']!,
                      ano: evento['ano']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}