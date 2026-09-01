import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroModelosPage extends StatefulWidget {
  const CadastroModelosPage({super.key});

  @override
  State<CadastroModelosPage> createState() => _CadastroModelosPageState();
}

class _CadastroModelosPageState extends State<CadastroModelosPage> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final anoController = TextEditingController();

  String? categoria;
  bool ativo = true;
  bool salvando = false;

  final categorias = [
    'HATCH',
    'SEDAN',
    'SUV',
    'PICKUP',
  ];

  Future<void> salvar() async{
    if(!formKey.currentState!.validate()){
      return;
    }

    final dadosModelo = {
      'NOME': nomeController.text,
      'CATEGORIA': categoria,
      'ANO_MODELO': anoController.text,
      'ATIVO': ativo ? '1' : '0',
    };

    setState(() {
      salvando = true;
    });

    // tenta enviar os dados para API
    try{
      // fazer uma requisição HTTP para API
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/modelos'),
        headers: {
          'Accept': 'application/json',
        },
        body: jsonEncode(dadosModelo)
      );

      // converte a resposta da API para JSON
      final resultado = response.body.isNotEmpty ? jsonDecode(response.body) : <String, dynamic>{};

      // verifica se o cadastro foi realizado com sucesso
      if(response.statusCode == 201){
        // mensagem de sucesso para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Modelo cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          )
        );
      }else{
        // caso a API retorne um erro, exibe a mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro $response.statusCode}: $response.body}'),
            backgroundColor: Colors.red,
          )
        );
      }

    } catch (e) {
      // mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar para a API'),
          backgroundColor: Colors.red,
        )
      );
    }
    // atualiza a tela para indicar q o envio terminou
    finally{
      setState(() {
        salvando = false;
      });
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
          'Cadastro de Modelos',
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
            constraints: const BoxConstraints(maxWidth: 600),
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
                        prefixIcon: Icon(Icons.directions_car_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: categoria,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        prefixIcon: Icon(Icons.category_outlined),
                        border: OutlineInputBorder(),
                      ),
                      items: categorias.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          categoria = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
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
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o ano';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Informe um ano válido';
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
                      onChanged: (value) {
                        setState(() {
                          ativo = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: salvar,
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        icon: const Icon(Icons.save_outlined),
                        label: const Text(
                          'SALVAR',
                          style: TextStyle(
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