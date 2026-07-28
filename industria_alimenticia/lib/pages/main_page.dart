import 'package:flutter/material.dart';
import 'package:industria_alimenticia/pages/cadastro_page.dart';
import 'package:industria_alimenticia/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Amazenar o índice da página selecionada
  int indiceAtual = 0;

  // Lista de páginas que serão exibidas
  final paginas = [
    HomePage(),
    CadastroPage(),
  ];

  // Lista de titulos exibidos na AppBar de acordo com a página selecionada
  final titulos = [
    'Inicio',
    'Cadastro',
  ];

  void selecionarPagina(int indice) {
    setState(() {
      indiceAtual = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior que exibe o titulo
      appBar: AppBar(
        title: Text(titulos[indiceAtual]),
        backgroundColor: Colors.green,
      ),
    );
  }
}