import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:industria_automobilistica/editar_fornecedores.dart';

class RelatorioFornecedoresPage extends StatefulWidget {
  const RelatorioFornecedoresPage({super.key});

  @override
  State<RelatorioFornecedoresPage> createState() => _RelatorioFornecedoresPageState();
}

class _RelatorioFornecedoresPageState extends State<RelatorioFornecedoresPage> {
  final ScrollController horizontalController = ScrollController();

  List<dynamic> fornecedores = [];

  bool carregando = true;

  String? erro;

  @override
  void initState(){
    super.initState();

    consultaFornecedores();
  }

  Future<void> consultaFornecedores() async {
    // Reinicia o estado antes de cada consulta (usado também pelo botão de refresh)
    setState(() {
      carregando = true;
      erro = null;
    });

    try{
      final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/fornecedores'),

        headers: {
          'Accept': 'application/json',
        }
      );

      final resultado = jsonDecode(response.body);

      if(response.statusCode == 200){
        setState(() {
          fornecedores = resultado['data'] ?? [];

          carregando = false;
        });
      } else {
        setState(() {
          erro = resultado['message'] ?? [];

          carregando = false;
        });
      }
    }catch(e){
      setState(() {
        erro =  'Erro: $e';
        carregando = false;
      });
    }
  }

  // Função que faz requisição assíncrona para a API mandando o DELETE
  Future<void> excluirFornecedor(dynamic idFornecedor) async {
    try{
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/fornecedores/$idFornecedor'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
      );

      final resultado = response.body.isNotEmpty ?
      jsonDecode(response.body) : null;

      if (!mounted) return;

      if(response.statusCode == 200){
        // Exibe uma mensagem mostrando que o registro foi excluido
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fornecedor excluído com sucesso!'))
      );

      //Atualizar a lista de fornecedores após a exclusão
      await consultaFornecedores();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado['message']))
      );
      }
    }catch(e){
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao acessar API: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Fornecedores'),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            // Desabilita o botão enquanto uma consulta já está em andamento
            onPressed: carregando ? null : consultaFornecedores,
            icon: const Icon(Icons.refresh),
          ),
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
                DataColumn(
                  label: Text(
                    'Ações',
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

                    // Nova célula para ações
                    DataCell(
                     Row(
                      children: [
                        IconButton(
                        onPressed: () async {
                          final atualizado = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                              EditarFornecedorPage(fornecedor:
                              Map<String, dynamic>.from(fornecedor))
                            )
                          );

                          if(atualizado == true){
                            await consultaFornecedores();
                          }
                        },
                        icon: Icon(Icons.edit,
                        color: Colors.lightBlue.shade900,
                        )
                        ),
                        IconButton(
                        onPressed: () async {
                          // Capturar id do registro para fazer DELETE no banco
                          final id = fornecedor['ID'];

                          // Exibe um diálogo de confirmação antes de excluir
                          final confirmacao = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Excluir fornecedor'),
                                content: Text('Deseja excluir seu fornecedor ${fornecedor['NOME']}?'),
                                actions: [
                                  // Botão de cancelamento que fecha o diálogo e retorna false
                                 TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text('Cancelar')
                                  ),
                                  // Botão de excluir que fecha o diálogo e retorna true
                                  TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('Excluir', style: TextStyle(color: Colors.red))
                                  ),
                                ],
                              );
                            }
                          );

                          if(confirmacao == true){
                            await excluirFornecedor(id);
                          }
                        },
                        icon: Icon(Icons.delete,
                        color: Colors.red,
                        )
                        )
                      ],
                     )
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
