import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroUsuario extends StatefulWidget{
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario>{
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  List<String> nomes = [

  ];

  List<String> telefones = [

  ];

  final telefoneMask = MaskTextInputFormatter(mask: '(##)#####-####');

  void adicionarDados(){
    if(nomeController.text.isEmpty){
      ScaffoldMessenger.of(
        context, 
      ).showSnackBar(SnackBar(content: Text("Campo nome e telefone obrigatório!")));

      return;
    }

    if(telefoneController.text.isEmpty){
      ScaffoldMessenger.of(
        context, 
      ).showSnackBar(SnackBar(content: Text("Campo nome e telefone obrigatório!")));

      return;
    }

    setState(() {
      nomes.add(nomeController.text);
      nomeController.clear();
    });

    setState(() {
      telefones.add(telefoneController.text);
      telefoneController.clear();
    });
  }

  // Função para remover dados do array
  void removerDados(int index){
    // Atualiza o estado da tela
    setState(() {
      // remover dados do array no index
      nomes.removeAt(index);
      telefones.removeAt(index);
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
                Expanded(
                  
                  child: TextField(
                    controller: telefoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [telefoneMask],
                    decoration: InputDecoration(
                      labelText: "Digite seu telefone",
                      border: OutlineInputBorder(),
                    ),
                  )
                ),
                

                ElevatedButton(onPressed: adicionarDados, child: Text("Adicionar"),)
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
                    removerDados(index);

                    // mostrar mensagem de sucesso na parte inferior
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nome e Telefone Removido com Sucesso!")));
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
            ),

          Expanded(
            child: ListView.builder(
              itemCount: telefones.length,
              itemBuilder: (context, index) {
                final telefone = telefones[index];
                return Dismissible(
                  key: UniqueKey(),

                  direction: DismissDirection.endToStart,

                  // evento disparado quando a pessoa arrastar
                  onDismissed: (direction) {
                    // Deleta item da lista
                    removerDados(index);

                    // mostrar mensagem de sucesso na parte inferior
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nome e Telefone Removido com Sucesso!")));
                  },

                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 255, 255),),
                  ),

                  child: ListTile(title: Text(telefone),)
                  );
              },
              )
            )

        ],
      ),
    );
  }
}