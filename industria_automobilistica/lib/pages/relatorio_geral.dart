import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RelatorioGeralPage extends StatefulWidget {
  const RelatorioGeralPage({super.key});

  @override
  State<RelatorioGeralPage> createState() => _RelatorioGeralPageState();
}

class _RelatorioGeralPageState extends State<RelatorioGeralPage> {
  // define constante da url de pesquisa da API
  static const baseUrl = 'http://127.0.0.1:8000/api';

  // indica se os dados estão sendos carregados (loader)
  bool carregando = true;

  // armazena uma possivel mensagem de erro
  String? erro;

  // armazena as quantidades de cada rota pesquisada
  int totalModelos = 0;
  int totalComponentes = 0;
  int totalForncedores = 0;
  int estoqueBaixo = 0;

  // consulta os dados assim q a página é aberta
  @override
  void initState(){
    super.initState();
    consultarDados();
  }

  // criando função que faz a busca na API
  Future<List<dynamic>> consultar(String endpoint) async{
    // realizar uma requisição HTTP GET
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers:{
        'Accept': 'application/json'
      }
    );

    final resultado = jsonDecode(response.body);

    if(response.statusCode != 200){
      throw Exception(
        resultado['message'] ?? 'Erro ao consultar API'
      );
    }

    return resultado['data'] ?? [];
  }

  // declara função q vai buscar todos os dados da API
  Future<void> consultarDados() async{
    setState(() {
      // Indicar q um consulta vai ser realizada
      carregando = true;
      erro = null;
    });

    try{
      // faz consulta na api
      final resultados = await Future.wait([
        // faz consultas simultaneamente
        consultar('modelos'),
        consultar('componentes'),
        consultar('fornecedores')
      ]);

      setState(() {
        // atualizar as quantidades nas variaves
        totalModelos = resultados[0].length;
        totalModelos = resultados[1].length;
        totalModelos = resultados[2].length;

        carregando = false;
      });
    }catch(e){
      setState(() {
        erro = e.toString();
        carregando = false;
      });
    }
  }

  Widget build(BuildContext context) {
    // criar a lista de indicadores para exibir no card
    final List<Map<String, dynamic>> indicadores = [
      {
        'titulo': 'Modelos',
        'valor': totalModelos.toString(),
        'icone': Icons.directions_car
      },
      {
        'titulo': 'Componentes',
        'valor': totalComponentes.toString(),
        'icone': Icons.settings
      },
      {
        'titulo': 'Fornecedores',
        'valor': totalForncedores.toString(),
        'icone': Icons.local_shipping
      },
      {
        'titulo': 'Estoque Baixo',
        'valor': estoqueBaixo.toString(),
        'icone': Icons.warning
      },
      
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Relatório Geral'),
        backgroundColor: const Color(0xFF164E63),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Visão geral',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: indicadores.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 160,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = indicadores[index];

                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          item['icone'],
                          size: 32,
                          color: const Color(0xFF0E7490),
                        ),
                        const Spacer(),
                        Text(
                          item['valor'],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item['titulo'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}