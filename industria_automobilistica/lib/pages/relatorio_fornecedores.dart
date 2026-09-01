import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelatorioFornecedoresPage extends StatefulWidget {
  const RelatorioFornecedoresPage({super.key});

  @override
  State<RelatorioFornecedoresPage> createState() => _RelatorioFornecedoresPageState();
}

class _RelatorioFornecedoresPageState extends State<RelatorioFornecedoresPage> {
  final ScrollController horizontalController = ScrollController();
  
  // Cria uma lista que armanezará os modelos pela API
  List<dynamic> fornecedores = []; 

  // indica se os dados ainda estão sendo carregados.
  // Começa com true porque a consulta será feita ao abrir a pág
  bool carregando = true;

  // Armazena um possível erro
  String? erro;

  @override
  // Função que vai executar ao abrir a tela
  void initState() {
    // Configuração para iniciar a tela
    super.initState();

    // Chama a função que chgama na API
    consultaFornecedores();
  }

  // Cria a função que faz a busca na API
  Future<void> consultaFornecedores() async {
    try {
      // Faz uma requisição HTTP do tipo GET para API.
      final response = await http.get(
        // Converte o endereço da API para um objeto URI;
        Uri.parse('http://127.0.0.1:8000/api/modelos'),

        // Informa à API que o aplicativo espera receber a resposta em JSON
        headers: {
          'Accept': 'application/json',
        }
      );

      // converte o texto JSON para um objeto Dart.
      final resultado = jsonDecode(response.body);

      // Verifica se a requisição foi concluída com sucesso.
      if (response.statusCode == 200) {
        // Atualiza o estado da tela.
        setState(() {
          // Armazenar os dados retornados pela API
          // Caso seja nulo, deixo a lista vazia
          fornecedores = resultado['data'] ?? [];

          // Parar o loader
          carregando = false;
        });
      } else {
        // Se API retornar erro, exibir erro na tela
        setState(() {
          erro = resultado['message'] ?? [];

          carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        erro = 'Erro: $e';
        carregando = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Fornecedores'),
        // Adicionar um botão lateral de atualizção
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                carregando = true;
                erro = null;
              });

              consultaFornecedores();
            }, 
            icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: 
      carregando
      ? const Center(child: CircularProgressIndicator())
      : erro != null ?
      Center(
        child: Text(erro!, style: TextStyle(color: Colors.red),),
      ) :
      Padding(
        padding: const EdgeInsets.all(24),
        child: Scrollbar(
          controller: horizontalController,
          thumbVisibility: true,
          trackVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: SingleChildScrollView(
            controller: horizontalController,
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                const Color(0xFFE7F0F2),
              ),
              border: TableBorder.all(
                color: const Color(0xFFE0E5E7),
                borderRadius: BorderRadius.circular(8),
              ),
              columns: const [
                DataColumn(
                  label: Text(
                    'Nome',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CNPJ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Cidade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Estado',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
               
              ],
              rows: fornecedores.map<DataRow>((fornecedor){
                return DataRow(
                  cells: [
                    DataCell(
                      Text(fornecedor['NOME'].toString()),
                    ),
                    DataCell(
                      Text(fornecedor['CNPJ'].toString()),
                    ),
                    DataCell(
                      Text(fornecedor['CIDADE'].toString()),
                    ),
                    DataCell(
                      Text(fornecedor['ESTADO'].toString()),
                    ),
                  ]
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}