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
    'descricao': 'Surgimento da escrita cuneiforme na Mesopotâmia, permitindo o registro de informações, leis e comércio, e marcando o fim da Pré-História e o início da História.'
  },
  {
    'ano': '753 a.C.',
    'titulo': 'Fundação de Roma',
    'descricao': 'Fundação lendária de Roma por Rômulo e Remo, dando início a uma civilização que se tornaria uma das mais influentes da Antiguidade.'
  },
  {
    'ano': '476',
    'titulo': 'Queda de Roma',
    'descricao': 'Deposição do último imperador romano do Ocidente por povos germânicos, simbolizando o fim da Antiguidade e o início da Idade Média.'
  },
  {
    'ano': '1095',
    'titulo': 'As Cruzadas',
    'descricao': 'Série de expedições militares organizadas pela Igreja Católica com o objetivo de reconquistar a Terra Santa, marcando intensos conflitos religiosos e culturais.'
  },
  {
    'ano': '1453',
    'titulo': 'Queda de Constantinopla',
    'descricao': 'Tomada da cidade pelos turcos-otomanos, encerrando o Império Bizantino e alterando rotas comerciais entre Europa e Ásia.'
  },
  {
    'ano': '1492',
    'titulo': 'Chegada à América',
    'descricao': 'Cristóvão Colombo chega ao continente americano, iniciando o contato entre Europa e Américas e um período de exploração e colonização.'
  },
  {
    'ano': '1760',
    'titulo': 'Revolução Industrial',
    'descricao': 'Início da mecanização da produção com o uso de máquinas e fábricas, transformando a economia, o trabalho e a sociedade.'
  },
  {
    'ano': '1789',
    'titulo': 'Revolução Francesa',
    'descricao': 'Movimento que começou com a Queda da Bastilha e levou ao fim do absolutismo na França, promovendo ideais de liberdade, igualdade e cidadania.'
  },
  {
    'ano': '1914',
    'titulo': 'Primeira Guerra Mundial',
    'descricao': 'Conflito global envolvendo grandes potências, caracterizado por guerras de trincheiras e novas tecnologias militares, com enormes impactos políticos.'
  },
  {
    'ano': '1939',
    'titulo': 'Segunda Guerra Mundial',
    'descricao': 'Maior conflito armado da história, envolvendo diversas nações e resultando em profundas mudanças geopolíticas e sociais no mundo.'
  },
  {
    'ano': '1969',
    'titulo': 'Homem na Lua',
    'descricao': 'Missão Apollo 11 leva os primeiros humanos à Lua, representando um marco da exploração espacial e da corrida tecnológica.'
  },
  {
    'ano': '1989',
    'titulo': 'Queda do Muro de Berlim',
    'descricao': 'Derrubada do muro que dividia Berlim, simbolizando o fim das divisões ideológicas da Guerra Fria e a reunificação da Alemanha.'
  },
  {
    'ano': '1991',
    'titulo': 'Criação da Web',
    'descricao': 'Desenvolvimento da World Wide Web, que revolucionou a comunicação, o acesso à informação e deu início à era digital moderna.'
  },
];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Linha do Tempo"),
        titleTextStyle: TextStyle(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.brown,
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// LINHA + BOLINHA
              Column(
                children: [
                  Container(
                    width: 2,
                    height: 20,
                    color: index == 0
                        ? Colors.transparent
                        : Colors.brown[400],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.circle, size: 8, color: Colors.white),
                  ),
                  Container(
                    width: 2,
                    height: 80,
                    color: index == eventos.length - 1
                        ? Colors.transparent
                        : Colors.brown[400]
                  ),
                ],
              ),

              const SizedBox(width: 12),

              /// CARD DO EVENTO
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
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
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.brown[400],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// ANO
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.brown[400],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              evento['ano']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          /// TITULO
                          Text(
                            evento['titulo']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          /// DESCRIÇÃO
                          Text(
                            evento['descricao']!,
                            style: const TextStyle(fontSize: 13,
                            color: Colors.white),
                          ),

                          const SizedBox(height: 10),

                          const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}