import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelatorioComponentesPage extends StatefulWidget {
  const RelatorioComponentesPage({super.key});

  @override
  State<RelatorioComponentesPage> createState() => _RelatorioComponentesPageState();
}

class _RelatorioComponentesPageState extends State<RelatorioComponentesPage> {
  final ScrollController horizontalController = ScrollController();
  
  // Cria uma lista que armanezará os modelos pela API
  List<dynamic> componentes = []; 

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
    consultaComponentes();
  }

  // Cria a função que faz a busca na API
  Future<void> consultaComponentes() async {
    try {
      // Faz uma requisição HTTP do tipo GET para API.
      final response = await http.get(
        // Converte o endereço da API para um objeto URI;
        Uri.parse('http://127.0.0.1:8000/api/componentes'),

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
          componentes = resultado['data'] ?? [];

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

  Future<void> excluirComponente(dynamic idComponente) async{
    try{
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/componentes/$idComponente'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }
      );

      final resultado = response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Componente excluído com sucesso!')),
        );

        await consultaComponentes();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir componente: ${resultado?['message'] ?? 'Erro desconhecido'}')),
        );
      }

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao acessar a API: $e')),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Componentes'),
        // Adicionar um botão lateral de atualizção
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                carregando = true;
                erro = null;
              });

              consultaComponentes();
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
                    'Codigo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Nome',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Estoque',
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
              rows: componentes.map<DataRow>((componete){
                return DataRow(
                  cells: [
                    DataCell(
                      Text(componete['CODIGO'].toString()),
                    ),
                    DataCell(
                      Text(componete['NOME'].toString()),
                    ),
                    DataCell(
                      Text(componete['ESTOQUE'].toString()),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Ação do botão de editar
                            },
                            icon: Icon(Icons.edit)
                          ),
                          IconButton(
                          onPressed: () async {
                            final id = componete['ID'];

                            // exibe um dialogo de config antes de excluir o componente
                            final confirmacao = await showDialog<bool>(
                              context:context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text('Excluir Componente'),
                                  content: Text('Deseja excluir o componente ${componete['NOME']}?'),
                                  actions: [
                                    // Botão de cancelar que fecha o diálogo e retorna false
                                    TextButton(
                                    onPressed: (){
                                      Navigator.pop(context,false);
                                    },
                                    child: Text('Cancelar')
                                    ),
                                    // Botão de excluir que fecha o diálogo e retorna true
                                    TextButton(
                                    onPressed: (){
                                      Navigator.pop(context,true);
                                    },
                                    child: Text('Excluir')
                                    ), 
                                  ],
                                );
                               }
                               );

                               if(confirmacao == true){
                                await excluirComponente(id);
                               }
                            },
                            icon: Icon(Icons.delete, color: Colors.red))
                        ],
                      )
                    ),
                  ]
                );
              }).toList()
            ),
          ),
        ),
      ),
    );
  }
}