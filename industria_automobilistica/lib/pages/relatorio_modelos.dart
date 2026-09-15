import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'editar_modelo.dart';

class RelatorioModelosPage extends StatefulWidget {
  const RelatorioModelosPage({super.key});

  @override
  State<RelatorioModelosPage> createState() => _RelatorioModelosPageState();
}

class _RelatorioModelosPageState extends State<RelatorioModelosPage> {
  final ScrollController horizontalController = ScrollController();

  List<dynamic> modelos = [];

  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    consultaModelos();
  }

  @override
  void dispose() {
    horizontalController.dispose();
    super.dispose();
  }

  Future<void> consultaModelos() async {
    if (mounted) {
      setState(() {
        carregando = true;
        erro = null;
      });
    }

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/modelos'),
        headers: {
          'Accept': 'application/json',
        },
      );

      final resultado =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          modelos = resultado?['data'] ?? [];
          carregando = false;
        });
      } else {
        setState(() {
          erro = resultado?['message']?.toString() ??
              'Erro ao carregar os modelos';
          carregando = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Erro ao acessar a API: $e';
        carregando = false;
      });
    }
  }

  Future<void> excluirModelo(dynamic idModelo) async {
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/modelos/$idModelo'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final resultado =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Modelo excluído com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        await consultaModelos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado?['message']?.toString() ??
                  'Erro ao excluir o modelo.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao acessar API: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> confirmarExclusao(Map<String, dynamic> modelo) async {
    final id = modelo['ID'];
    final nome = modelo['NOME']?.toString() ?? 'este modelo';

    final confirmacao = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir modelo'),
          content: Text(
            'Deseja realmente excluir o modelo "$nome"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Excluir',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      await excluirModelo(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Modelos'),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            onPressed: carregando ? null : consultaModelos,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : erro != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      erro!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : modelos.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum modelo encontrado.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Scrollbar(
                        controller: horizontalController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        scrollbarOrientation:
                            ScrollbarOrientation.bottom,
                        child: SingleChildScrollView(
                          controller: horizontalController,
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor:
                                WidgetStateProperty.all(
                              const Color(0xFFE7F0F2),
                            ),
                            border: TableBorder.all(
                              color: const Color(0xFFE0E5E7),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Nome',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Categoria',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ano do modelo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ativo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ações',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: modelos.map<DataRow>((modelo) {
                              final ativo =
                                  modelo['ATIVO']?.toString() ?? '0';

                              final modeloMap =
                                  Map<String, dynamic>.from(modelo);

                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      modelo['NOME']?.toString() ??
                                          '',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      modelo['CATEGORIA']
                                              ?.toString() ??
                                          '',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      modelo['ANO_MODELO']
                                              ?.toString() ??
                                          '',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      ativo == '1'
                                          ? 'Sim'
                                          : 'Não',
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          tooltip: 'Editar',
                                          onPressed: () async {
                                            final atualizado =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarModeloPage(
                                                  modelo: modeloMap,
                                                ),
                                              ),
                                            );

                                            if (atualizado == true &&
                                                mounted) {
                                              await consultaModelos();
                                            }
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors
                                                .lightBlue
                                                .shade900,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Excluir',
                                          onPressed: () {
                                            confirmarExclusao(
                                              modeloMap,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
    );
  }
}