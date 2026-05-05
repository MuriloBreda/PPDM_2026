import 'package:flutter/material.dart';

class QuizHistoria extends StatefulWidget {
  const QuizHistoria({super.key});

  @override
  State<QuizHistoria> createState() => _QuizHistoriaState();
}

class _QuizHistoriaState extends State<QuizHistoria> {
  int perguntaAtual = 0;
  int pontuacao = 0;

  final List<Map<String, Object>> perguntas = [
    {
      'pergunta': 'O que aconteceu em 4000 a.C.?',
      'respostas': [
        {'texto': 'Fundação de Roma', 'correta': false},
        {'texto': 'Revolução Industrial', 'correta': false},
        {'texto': 'Invenção da escrita', 'correta': true},
      ],
    },
    {
      'pergunta': 'Qual evento ocorreu em 753 a.C.?',
      'respostas': [
        {'texto': 'Queda de Roma', 'correta': false},
        {'texto': 'Fundação de Roma', 'correta': true},
        {'texto': 'Cruzadas', 'correta': false},
      ],
    },
    {
      'pergunta': 'O que marcou o ano de 476?',
      'respostas': [
        {'texto': 'Queda de Roma', 'correta': true},
        {'texto': 'Revolução Francesa', 'correta': false},
        {'texto': 'Chegada à América', 'correta': false},
      ],
    },
    {
      'pergunta': 'O que foram as Cruzadas (1095)?',
      'respostas': [
        {'texto': 'Revolução política', 'correta': false},
        {'texto': 'Descoberta científica', 'correta': false},
        {'texto': 'Expedições militares cristãs', 'correta': true},
      ],
    },
    {
      'pergunta': 'O que aconteceu em 1453?',
      'respostas': [
        
        {'texto': 'Homem na Lua', 'correta': false},
        {'texto': 'Queda de Constantinopla', 'correta': true},
        {'texto': 'Criação da Web', 'correta': false},
      ],
    },
    {
      'pergunta': 'Quem chegou à América em 1492?',
      'respostas': [
        
        {'texto': 'Napoleão', 'correta': false},
        {'texto': 'Cristóvão Colombo', 'correta': true},
        {'texto': 'Einstein', 'correta': false},
      ],
    },
    {
      'pergunta': 'O que marcou 1760?',
      'respostas': [
        {'texto': 'Segunda Guerra', 'correta': false},
        {'texto': 'Queda do Muro', 'correta': false},
        {'texto': 'Revolução Industrial', 'correta': true},
      ],
    },
    {
      'pergunta': 'O que ocorreu em 1789?',
      'respostas': [
        {'texto': 'Primeira Guerra', 'correta': false},
        {'texto': 'Revolução Francesa', 'correta': true},
        {'texto': 'Criação da Web', 'correta': false},
      ],
    },
    {
      'pergunta': 'Quando começou a Primeira Guerra Mundial?',
      'respostas': [
        {'texto': '1914', 'correta': true},
        {'texto': '1939', 'correta': false},
        {'texto': '1989', 'correta': false},
      ],
    },
    {
      'pergunta': 'Quando começou a Segunda Guerra Mundial?',
      'respostas': [
        {'texto': '1939', 'correta': true},
        {'texto': '1914', 'correta': false},
        {'texto': '1969', 'correta': false},
      ],
    },
    {
      'pergunta': 'O que aconteceu em 1969?',
      'respostas': [
        
        {'texto': 'Queda de Roma', 'correta': false},
        {'texto': 'Homem na Lua', 'correta': true},
        {'texto': 'Cruzadas', 'correta': false},
      ],
    },
    {
      'pergunta': 'O que marcou 1989?',
      'respostas': [
        
        {'texto': 'Revolução Industrial', 'correta': false},
        {'texto': 'Descoberta da América', 'correta': false},
        {'texto': 'Queda do Muro de Berlim', 'correta': true},
      ],
    },
    {
      'pergunta': 'O que aconteceu em 1991?',
      'respostas': [
        {'texto': 'Criação da Web', 'correta': true},
        {'texto': 'Primeira Guerra', 'correta': false},
        {'texto': 'Fundação de Roma', 'correta': false},
      ],
    },
  ];

  void responder(bool correta) {
    if (correta) pontuacao++;

    setState(() {
      perguntaAtual++;
    });
  }

  void reiniciar() {
    setState(() {
      perguntaAtual = 0;
      pontuacao = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool terminou = perguntaAtual >= perguntas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz História'), 
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: terminou
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Você acertou $pontuacao de ${perguntas.length}!',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: reiniciar,
                    child: const Text('Reiniciar Quiz'),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    perguntas[perguntaAtual]['pergunta'] as String,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...(perguntas[perguntaAtual]['respostas']
                          as List<Map<String, Object>>)
                      .map((resposta) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () =>
                            responder(resposta['correta'] as bool),
                        child: Text(resposta['texto'] as String),
                      ),
                    );
                  }).toList()
                ],
              ),
      ),
    );
  }
}