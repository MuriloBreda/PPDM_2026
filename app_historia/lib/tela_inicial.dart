import 'package:flutter/material.dart';
import 'tela_conteudo.dart';
import 'tela_exemplo_logica.dart';
import 'tela_linha_do_tempo.dart';
import 'quiz_prehistoria.dart'; 

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});
  @override
  Widget build(BuildContext context) {
    final materias = [
  {
    "titulo": "Pré-História",
    "descricao": "Surgimento do Homo Sapiens e a invenção da escrita.",
    "descricaoCompleta": "Período que abrange desde os primeiros ancestrais humanos até o desenvolvimento das primeiras formas de comunicação escrita, marcado pela evolução das ferramentas, domínio do fogo, organização em grupos sociais e surgimento das primeiras expressões culturais como pinturas rupestres.",
    "link": "https://super.abril.com.br/wp-content/uploads/2018/07/573f79010e21634575052021pre-historia-e-o-porque-usamos-roupas-1170x5501.jpeg?quality=70&strip=info&resize=1080,565&crop=1",
  },
  {
    "titulo": "Antiguidade Clássica",
    "descricao": "O apogeu da Grécia Antiga e do Império Romano.",
    "descricaoCompleta": "Fase caracterizada pelo desenvolvimento da filosofia, política, artes e ciência, com a criação da democracia em Atenas e a expansão territorial e administrativa de Roma, influenciando profundamente a cultura ocidental.",
    "link": "https://i.pinimg.com/564x/e0/bc/fa/e0bcfa6998b1f75c7b9897a5c1dbf297.jpg",
  },
  {
    "titulo": "Queda de Roma",
    "descricao": "O fim do Império Romano do Ocidente e início da Idade Média.",
    "descricaoCompleta": "Evento ocorrido em 476 d.C., marcado por invasões bárbaras, crises internas e fragmentação política, que resultaram na descentralização do poder e mudanças sociais na Europa.",
    "link": "https://static.historiadomundo.com.br/2024/04/1-ilustracao-retratando-combate-entre-romanos-e-barbaros-em-referencia-a-queda-do-imperio-romano.jpg",
  },
  {
    "titulo": "Idade Média",
    "descricao": "Feudalismo, expansão do Islã e as Cruzadas.",
    "descricaoCompleta": "Período histórico caracterizado pela economia agrária, poder descentralizado dos senhores feudais, forte influência da Igreja Católica e conflitos religiosos, além do crescimento de cidades e comércio no final da era.",
    "link": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdw-_wGHlVmsxnfAR0607JmRqSwt-cE0cLaw&s",
  },
  {
    "titulo": "Renascimento",
    "descricao": "Transição para a Idade Moderna com foco na ciência e artes.",
    "descricaoCompleta": "Movimento cultural que valorizou o conhecimento clássico, incentivou avanços científicos, artísticos e filosóficos, destacando o humanismo e grandes nomes como artistas e pensadores inovadores.",
    "link": "https://images.educamaisbrasil.com.br/content/banco_de_imagens/guia-de-estudo/D/renascimento-michelangelo-artes.jpg",
  },
  {
    "titulo": "Grandes Navegações",
    "descricao": "Exploração global e o encontro entre Europa e Américas.",
    "descricaoCompleta": "Período de expansão marítima europeia entre os séculos XV e XVII, impulsionado por interesses comerciais, resultando na colonização de novos territórios e intensificação das trocas culturais e econômicas.",
    "link": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKKTMr1zINM_2eDAx8NKLlJezu19BxJwzQMg&s",
  },
  {
    "titulo": "Revolução Industrial",
    "descricao": "Transformação tecnológica e mudança na produção mundial.",
    "descricaoCompleta": "Processo iniciado no século XVIII que introduziu máquinas, fábricas e novas formas de trabalho, alterando profundamente a economia, urbanização e relações sociais.",
    "link": "https://static.todamateria.com.br/upload/re/vo/revolucao-industrial-og.jpg?class=ogImageSquare",
  },
  {
    "titulo": "Revolução Francesa",
    "descricao": "Fim do absolutismo e ascensão dos ideais de liberdade e igualdade.",
    "descricaoCompleta": "Movimento ocorrido em 1789 que derrubou a monarquia francesa, estabeleceu novos princípios políticos e influenciou diversas revoluções ao redor do mundo.",
    "link": "https://static.historiadomundo.com.br/2021/05/revolucao-francesa.jpg",
  },
  {
    "titulo": "Primeira Guerra Mundial",
    "descricao": "O primeiro grande conflito global do século XX.",
    "descricaoCompleta": "Guerra entre 1914 e 1918 envolvendo grandes potências mundiais, marcada por trincheiras, novas tecnologias militares e profundas consequências políticas e econômicas.",
    "link": "https://static.todamateria.com.br/upload/1e/9c/1e9c8b0a2f5d4b3e7c8f0a9e5b6c8f1.jpg?class=ogImageSquare",
  },
  {
    "titulo": "Segunda Guerra Mundial",
    "descricao": "Conflito contra o nazifascismo e a criação da ONU.",
    "descricaoCompleta": "Guerra global entre 1939 e 1945 que resultou na derrota das potências do Eixo, revelou os horrores do Holocausto e levou à reorganização da ordem mundial.",
    "link": "https://static.todamateria.com.br/upload/1e/9c/1e9c8b0a2f5d4b3e7c8f0a9e5b6c8f1.jpg?class=ogImageSquare",
  },
  {
    "titulo": "Guerra Fria",
    "descricao": "Disputa ideológica e tecnológica entre EUA e URSS.",
    "descricaoCompleta": "Período de tensão entre 1947 e 1991, sem confronto direto, marcado por corrida armamentista, espacial e influência política global entre capitalismo e socialismo.",
    "link": "https://static.todamateria.com.br/upload/1e/9c/1e9c8b0a2f5d4b3e7c8f0a9e5b6c8f1.jpg?class=ogImageSquare",
  },
  {
    "titulo": "Era Digital",
    "descricao": "A revolução da informação e a globalização tecnológica.",
    "descricaoCompleta": "Período contemporâneo caracterizado pelo avanço da internet, inteligência artificial, comunicação instantânea e transformação digital que impacta todos os setores da sociedade.",
    "link": "https://static.todamateria.com.br/upload/1e/9c/1e9c8b0a2f5d4b3e7c8f0a9e5b6c8f1.jpg?class=ogImageSquare",
  }
];

    return Scaffold(
      backgroundColor: const Color.fromARGB(29, 121, 85, 72),
        appBar: AppBar(
          title: const Text(
          "História",
            style: TextStyle(
              fontWeight: FontWeight.bold,
                color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

            // TÍTULO
            Container(
              width: double.infinity,
                padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.brown,
                  borderRadius: BorderRadius.circular(15),
              ),

              child: const Column(
                children: [

                  Text(
                    "Linha do Tempo da História",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Explore os principais acontecimentos históricos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // LISTA
            Expanded(
              child: ListView.builder(
                itemCount: materias.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 38, 92, 40),
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        materias[index]['titulo']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          materias[index]['descricao']!,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.brown,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TelaConteudo(
                              titulo: materias[index]['titulo']!,
                              descricao: materias[index]['descricao']!,
                              descricaoCompleta: materias[index]['descricaoCompleta']!,
                              link: materias[index]['link']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            // BOTÃO LINHA DO TEMPO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 84, 59, 50),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaLinhaDoTempo(),
                    ),
                  );
                },

                label: const Text(
                  "Ver Linha do Tempo",
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // BOTÃO ADICIONAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 84, 59, 50),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaExemploLogica(),
                    ),
                  );
                },
                label: const Text(
                  "Adicionar Acontecimento",
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // BOTÃO QUIZ
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 84, 59, 50),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuizHistoria(),
                    ),
                  );
                },
                  label: const Text(
                  "Quiz História",
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}