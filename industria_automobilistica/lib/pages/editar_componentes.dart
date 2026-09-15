import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditarComponentesPage extends StatefulWidget {
  final Map<String, dynamic> componente;

  const EditarComponentesPage({
    super.key,
    required this.componente,
  });

  @override
  State<EditarComponentesPage> createState() =>
      _EditarComponentesPageState();
}

class _EditarComponentesPageState
    extends State<EditarComponentesPage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nomeController;
  late final TextEditingController descricaoController;
  late final TextEditingController quantidadeController;
  late final TextEditingController valorController;

  bool ativo = true;
  bool salvando = false;
  String? erro;

  @override
  void initState() {
    super.initState();

    nomeController = TextEditingController(
      text: widget.componente['NOME']?.toString() ?? '',
    );

    descricaoController = TextEditingController(
      text:
          widget.componente['DESCRICAO']?.toString() ?? '',
    );

    quantidadeController = TextEditingController(
      text:
          widget.componente['QUANTIDADE']?.toString() ?? '',
    );

    valorController = TextEditingController(
      text:
          widget.componente['VALOR']?.toString() ?? '',
    );

    ativo =
        widget.componente['ATIVO']?.toString() == '1';
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    quantidadeController.dispose();
    valorController.dispose();

    super.dispose();
  }

  Future<void> editarComponente() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final dadosComponente = {
      'NOME': nomeController.text.trim(),
      'DESCRICAO': descricaoController.text.trim(),
      'QUANTIDADE':
          quantidadeController.text.trim(),
      'VALOR': valorController.text.trim(),
      'ATIVO': ativo ? '1' : '0',
    };

    setState(() {
      salvando = true;
      erro = null;
    });

    try {
      final id = widget.componente['ID'];

      final response = await http.put(
        Uri.parse(
          'http://127.0.0.1:8000/api/componentes/$id',
        ),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(dadosComponente),
      );

      final resultado = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : null;

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado?['message'] ??
                  'Componente atualizado com sucesso!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context, true);
      } else {
        setState(() {
          erro =
              'Erro ${response.statusCode}: ${response.body}';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Erro ao acessar a API: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          salvando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1F4E5F);
    const backgroundColor = Color(0xFFF2F4F5);
    const textColor = Color(0xFF263238);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Editar Componente',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE0E5E7),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Dados do componente',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        prefixIcon:
                            Icon(Icons.build_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Informe o nome';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller:
                          descricaoController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        prefixIcon:
                            Icon(Icons.description_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller:
                          quantidadeController,
                      keyboardType:
                          TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade',
                        prefixIcon:
                            Icon(Icons.numbers_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Informe a quantidade';
                        }

                        if (int.tryParse(
                                value.trim()) ==
                            null) {
                          return 'Informe uma quantidade válida';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: valorController,
                      keyboardType:
                          const TextInputType
                              .numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                        prefixIcon:
                            Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Informe o valor';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Componente ativo',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        ativo ? 'Ativo' : 'Inativo',
                      ),
                      value: ativo,
                      activeTrackColor:
                          primaryColor,
                      onChanged: salvando
                          ? null
                          : (value) {
                              setState(() {
                                ativo = value;
                              });
                            },
                    ),

                    const SizedBox(height: 20),

                    if (erro != null)
                      Container(
                        padding:
                            const EdgeInsets.all(12),
                        margin:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: Text(
                          erro!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),

                    SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed:
                            salvando
                                ? null
                                : editarComponente,
                        style:
                            FilledButton.styleFrom(
                          backgroundColor:
                              primaryColor,
                        ),
                        icon: salvando
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.save_outlined,
                              ),
                        label: Text(
                          salvando
                              ? 'SALVANDO...'
                              : 'ATUALIZAR',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}