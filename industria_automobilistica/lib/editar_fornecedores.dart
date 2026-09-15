import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditarFornecedorPage extends StatefulWidget {
  // Variável para armazenar o fornecedor a ser editado
  final Map<String, dynamic> fornecedor;


  // Recebe o fornecedor como parâmetro
  const EditarFornecedorPage({super.key, required this.fornecedor});

  @override
  State<EditarFornecedorPage> createState() => _EditarFornecedorPageState();
}

class _EditarFornecedorPageState extends State<EditarFornecedorPage> {
  // variáveis para armazenar os campos do formulário
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nomeController;
  late final TextEditingController cnpjController;
  late final TextEditingController cidadeController;
  late final TextEditingController estadoController;

  bool salvando = false;
  String? erro;

  @override
  void initState(){
    super.initState();

    // Inicializar os controladores de texto com os valores do fornecedor recebido
    nomeController = TextEditingController(
      text: widget.fornecedor['NOME']?.toString() ?? ''
    );

    cnpjController = TextEditingController(
      text: widget.fornecedor['CNPJ']?.toString() ?? ''
    );

    cidadeController = TextEditingController(
      text: widget.fornecedor['CIDADE']?.toString() ?? ''
    );

    estadoController = TextEditingController(
      text: widget.fornecedor['ESTADO']?.toString() ?? ''
    );
  }

  // Criar a função que faz o envio (PUT) para a API
  Future<void> editarFornecedor() async{
    // validar o formuláio antes de enviar a API
    if(!formKey.currentState!.validate()){
      return;
    }

    // Criar um JSON com os dados do fornecedor
    final dadosFornecedor = {
      'NOME': nomeController.text,
      'CNPJ': cnpjController.text,
      'CIDADE': cidadeController.text,
      'ESTADO': estadoController.text.toUpperCase(),
    };

    // Atualiza o estado da tela para indicar que está sendo salvo e tembém limpa a mensagem deerro se estiver sendo exibida
    setState(() {
      salvando = true;
      erro = null;
    });

    // Tentar enviar os dados para a API
    try{
      // Capturar campo ID do registro para alteração
      final id = widget.fornecedor['ID'];

      // Faz a requisição PUT para a API
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/fornecedores/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body:  jsonEncode(dadosFornecedor)
      );

      // Capturar a resposta da API
      final resultado = response.body.isNotEmpty ?
      jsonDecode(response.body) : null;

      // Verifica se a atualização foi realizada com sucesso
      if(response.statusCode == 200){
      // Menssagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          resultado['message'] ?? 'Fornecedor atualizado!'
          ),
          backgroundColor: Colors.green,
        )
      );

      // Volta para a página de relatórios fornecedor
      Navigator.pop(context, true);
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          'Erro ${response.statusCode}: ${response.body}'
        )
        )
      );
    }

    }catch (e){
      setState(() {
        erro = 'Erro ao acessar a API: $e';
        salvando = false;
      });
    }finally {
      if(mounted){
        setState(() {
          salvando = false;
        });
      }
    }
  }



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
          'Cadastro de Fornecedores',
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
                      'Dados do fornecedor',
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
                        prefixIcon: Icon(Icons.business_outlined),
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
                    TextFormField(
                      controller: cnpjController,
                      keyboardType: TextInputType.number,
                      maxLength: 14,
                      decoration: const InputDecoration(
                        labelText: 'CNPJ',
                        prefixIcon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o CNPJ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: cidadeController,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        labelText: 'Cidade',
                        prefixIcon: Icon(Icons.location_city_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a cidade';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: estadoController,
                      maxLength: 2,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'Estado (UF)',
                        prefixIcon: Icon(Icons.map_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o estado';
                        }
                        if (value.trim().length != 2) {
                          return 'Use a sigla com 2 letras';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: salvando ? null : editarFornecedor,
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        icon: const Icon(Icons.save_outlined),
                        label: const Text(
                          'ATUALIZAR',
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
