import 'package:flutter/material.dart';
import 'tela_conteudo.dart';
import 'tela_exemplo_logica.dart';
import 'tela_linha_do_tempo.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final materias = [
      {'titulo': 'Pré-História', 'descricao': 'Surgimento do Homo Sapiens e a invenção da escrita.'},
      {'titulo': 'Antiguidade Clássica', 'descricao': 'O apogeu da Grécia Antiga e do Império Romano.'},
      {'titulo': 'Queda de Roma', 'descricao': 'O fim do Império Romano do Ocidente e início da Idade Média.'},
      {'titulo': 'Idade Média', 'descricao': 'Feudalismo, expansão do Islã e as Cruzadas.'},
      {'titulo': 'Renascimento', 'descricao': 'Transição para a Idade Moderna com foco na ciência e artes.'},
      {'titulo': 'Grandes Navegações', 'descricao': 'Exploração global e o encontro entre Europa e Américas.'},
      {'titulo': 'Revolução Industrial', 'descricao': 'Transformação tecnológica e mudança na produção mundial.'},
      {'titulo': 'Revolução Francesa', 'descricao': 'Fim do absolutismo e ascensão dos ideais de liberdade e igualdade.'},
      {'titulo': 'Primeira Guerra Mundial', 'descricao': 'O primeiro grande conflito global do século XX.'},
      {'titulo': 'Segunda Guerra Mundial', 'descricao': 'Conflito contra o nazifascismo e a criação da ONU.'},
      {'titulo': 'Guerra Fria', 'descricao': 'Disputa ideológica e tecnológica entre EUA e URSS.'},
      {'titulo': 'Era Digital', 'descricao': 'A revolução da informação e a globalização tecnológica.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("História"),

      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            // LISTA
            Expanded(
              child: ListView.builder(
                itemCount: materias.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      

                      title: Text(
                        materias[index]['titulo']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      subtitle: Text(materias[index]['descricao']!),

                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TelaConteudo(
                              titulo: materias[index]['titulo']!,
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


            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TelaLinhaDoTempo(),
                  ),
                );
              },
              child: const Text("Ver Linha do Tempo"),
            ),

            SizedBox(
              child: ElevatedButton(
                
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaExemploLogica(),
                    ),
                  );
                },
                child: const Text("Adicionar acontecimento"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}