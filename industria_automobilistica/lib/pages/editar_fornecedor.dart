import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditarModeloPage extends StatefulWidget {
  final Map<String, dynamic> modelo;

  const EditarModeloPage({
    super.key,
    required this.modelo,
  });

  @override
  State<EditarModeloPage> createState() => _EditarModeloPageState();
}

class _EditarModeloPageState extends State<EditarModeloPage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nomeController;
  late final TextEditingController anoController;

  bool ativo = true;
  String? categoria;

  final categorias = [
    'HATCH',
    'SEDAN',
    'SUV',
    'PICAPE',
  ];

  bool salvando = false;
  String? erro;

  @override
  void initState() {
    super.initState();

    nomeController = TextEditingController(
      text: widget.modelo['NOME']?.toString() ?? '',
    );

    anoController = TextEditingController(
      text: widget.modelo['ANO_MODELO']?.toString() ?? '',
    );

    categoria = widget.modelo['CATEGORIA']?.toString();

    ativo = widget.modelo['ATIVO'].toString() == '1';
  }

  @override
  void dispose() {
    nomeController.dispose();
    anoController.dispose();
    super.dispose();
  }

  Future<void> editarModelo() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final dadosModelo = {
      'NOME': nomeController.text.trim(),
      'CATEGORIA': categoria,
      'ANO_MODELO': anoController.text.trim(),
      'ATIVO': ativo ? '1' : '0',
    };

    setState(() {
      salvando = true;
      erro = null;
    });

    try {
      final id = widget.modelo['ID'];

      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/modelos/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(dadosModelo),
      );

      final resultado =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado?['message'] ?? 'Modelo atualizado com sucesso!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context, true);
      } else {
        setState(() {
          erro = 'Erro ${response.statusCode}: ${response.body}';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ${response.statusCode}: ${response.body}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Erro ao acessar a API: $e';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao acessar a API: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
          'Editar Modelo',
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Dados do modelo',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    TextFormField(
                      controller: nomeController,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(
                          Icons.directions_car_outlined,
                        ),
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

                    DropdownButtonFormField<String>(
                      initialValue: categoria,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        prefixIcon: Icon(
                          Icons.category_outlined,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      items: categorias.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: salvando
                          ? null
                          : (value) {
                              setState(() {
                                categoria = value;
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione a categoria';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: anoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Ano do modelo',
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Informe o ano';
                        }

                        final ano = int.tryParse(
                          value.trim(),
                        );

                        if (ano == null) {
                          return 'Informe um ano válido';
                        }

                        if (ano < 1900 || ano > 2100) {
                          return 'Informe um ano entre 1900 e 2100';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Modelo ativo',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        ativo ? 'Ativo' : 'Inativo',
                      ),
                      value: ativo,
                      activeTrackColor: primaryColor,
                      onChanged: salvando
                          ? null
                          : (value) {
                              setState(() {
                                ativo = value;
                              });
                            },
                    ),

                    const SizedBox(height: 24),

                    if (erro != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.shade200,
                          ),
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
                        onPressed: salvando
                            ? null
                            : editarModelo,
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        icon: salvando
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
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