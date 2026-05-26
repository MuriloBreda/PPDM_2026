import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget{
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage>{
  TextEditingController nomeController = TextEditingController();

  List<String> nomes = [

  ];

  void adicionarNome(){
    if(nomeController.text.isEmpty){
      ScaffoldMessenger.of(
        context, 
      ).showSnackBar(SnackBar(content: Text("Campo nome obrigatório!")));

      return;
    }

    setState(() {
      nomes.add(nomeController.text);
      nomeController.clear();
    });
  }

  // Função para remover um nome do array
  void removerNome(int index){
    // Atualiza o estado da tela
    setState(() {
      // remover nome do array no index
      nomes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      labelText: "Digite seu nome",
                      border: OutlineInputBorder(),
                    ),
                  ) 
                ),
                SizedBox(width: 10),

                ElevatedButton(onPressed: adicionarNome, child: Text("Adicionar"),)
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: nomes.length,
              itemBuilder: (context, index) {
                final nome = nomes[index];
                return Dismissible(
                  key: UniqueKey(),

                  direction: DismissDirection.endToStart,

                  // evento disparado quando a pessoa arrastar
                  onDismissed: (direction) {
                    // Deleta item da lista
                    removerNome(index);

                    // mostrar mensagem de sucesso na parte inferior
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nome Removido com Sucesso!")));
                  },

                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 255, 255),),
                  ),

                  child: ListTile(title: Text(nome),)
                  );
              },
              )
            )

        ],
      ),
    );
  }
}