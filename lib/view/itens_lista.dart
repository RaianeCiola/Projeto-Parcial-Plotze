// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/lista_itens.dart';

class Itens_ListaView extends StatefulWidget {
  const Itens_ListaView({Key? key, required this.lista}) : super(key: key);
  final List<Itens_Lista> lista;

  @override
  State<Itens_ListaView> createState() => _Itens_ListaViewState();
}

class _Itens_ListaViewState extends State<Itens_ListaView> {
  late List<Itens_Lista> lista; // Lista de itens
  TextEditingController _controller = TextEditingController();
  bool isSearching = false; // Flag para indicar se está em modo de pesquisa

  @override
  initState() {
    super.initState();
    lista = widget.lista;
   
  }
  //esse parte é necessaria para não sumir os itens da lista se voltar para tela login
  //Nâo MEXEr
 @override 
  didUpdateWidget(covariant Itens_ListaView oldWidget) {
    super.didUpdateWidget(oldWidget);
    carregarLista();
  }
//caixa de texto rpincipal  caixaDialogo(BuildContext context, int index) {
  caixaDialogo(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opções'),
          content: Text('O que você gostaria de fazer?',
              style: TextStyle(
                fontSize: 20,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                editarIrem(index); // Abrir caixa de diálogo para editar
              },
              child: Text('Editar',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exluirItem(index); // Remover o item selecionado
              },
              child: Text('Excluir',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
          ],
        );
      },
    );
  }

  //Corpo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text('Seus Itens'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Função para adicionar novo item
              adicionarItem(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              pesquisarItem(
                  context); // Abre a caixa de diálogo para pesquisa de itens
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Exibir caixa de diálogo de ajuda
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Ajuda'),
                    content: Text(
                      '\n--> Essa tela contém os Itens da sua Lista!'
                      '\n--> Clique no ícone de "+" no canto superior direito para adicionar '
                      'itens a sua lista. '
                      '\n--> Precione o item da lista para editar ou excluir.'
                      '\n--> Clique na caixinha ao lado de cada item para marcar como item comprado/realizado! '
                      '\n--> Clique no ícone da lupa no canto superior direito para localizar os itens da sua lista. ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Fechar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: lista[index].comprado
                        ? Colors.green.shade100
                        : Colors.blueGrey.shade50,
                    child: ListTile(
                      title: Text(
                        lista[index].nome,
                        style: TextStyle(
                          fontSize: 18, 
                        
                        ),
                      ),
                      subtitle: Text(
                        lista[index].quant,
                        style: TextStyle(
                          fontSize: 16, 
                        ),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Precione para Editar ou Excluir',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        caixaDialogo(context, index);
                      },
                      trailing: Checkbox(
                        value: lista[index].comprado,
                        onChanged: (value) {
                          setState(() {
                            lista[index].comprado = value ?? false;
                          });
                          salvarLista();
                        },
                        activeColor: Colors.green.shade800,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para adicionar um novo item à lista
  adicionarItem(BuildContext context) async {
    String nome = '';
    String quant = '';

    final novoItem = await showDialog<Itens_Lista>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Novo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  nome = value;
                },
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                onChanged: (value) {
                  quant = value;
                },
                decoration: InputDecoration(labelText: 'Quantidade/Notas'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar',style: TextStyle(
                        fontSize: 20,
                      ),),
            ),
            TextButton(
              onPressed: () {
                final novoItem = Itens_Lista(nome: nome, quant: quant);
                setState(() {
                  lista.add(novoItem);
                });
                Navigator.of(context).pop(novoItem);
              },
              child: Text('Adicionar',style: TextStyle(
                        fontSize: 20,
                      ),),
            ),
          ],
        );
      },
    );

    if (novoItem != null) {
      salvarLista();
    }
  }

// excluir um item da lista
  exluirItem(int index) {
    setState(() {
      lista.removeAt(index);
    });
    salvarLista();
  }

  // carregar a lista de itens
  carregarLista() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = prefs.getString('lista_itens'); // Usar a chave correta
    if (listaJson != null) {
      final decoded = json.decode(listaJson) as List<dynamic>;
      setState(() {
        lista = decoded.map((item) => Itens_Lista.fromJson(item)).toList();
      });
    } else {
      setState(() {
        lista = widget.lista;
      });
    }
  }

  // salvar a lista de itens
  salvarLista() async {
    final prefs = await SharedPreferences.getInstance();
    final listaString = lista.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList('lista_itens', listaString);
  }

  // editar um item na lista
  editarIrem(int index) async {
    String nome = lista[index].nome;
    String quant = lista[index].quant;

    final editedItem = await showDialog<Itens_Lista>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  nome = value;
                },
                decoration: InputDecoration(labelText: 'Nome'),
                controller: TextEditingController(text: nome),
              ),
              TextField(
                onChanged: (value) {
                  quant = value;
                },
                decoration: InputDecoration(labelText: 'Quantidade'),
                controller: TextEditingController(text: quant),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            TextButton(
              onPressed: () {
                final editedItem = Itens_Lista(nome: nome, quant: quant);
                setState(() {
                  lista[index] = editedItem;
                });
                Navigator.of(context).pop(editedItem);
              },
              child: Text('Salvar',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
          ],
        );
      },
    );

    if (editedItem != null) {
      salvarLista();
    }
  }

  /// pesquisar itens na lista pelo nome
  //Depois de pesquisar não consegue editar ou excluir, só muda o check box
  pesquisarItem(BuildContext context) async {
    setState(() {
      isSearching = true;
    });

    String query = '';
    await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pesquisar Itens'),
          content: TextField(
            controller: _controller,
            onChanged: (value) {
              query = value;
            },
            decoration: InputDecoration(
              hintText: 'Digite o nome do item',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (query.isNotEmpty) {
                    lista = widget.lista
                        .where((item) => item.nome
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  } else {
                    lista = widget.lista;
                  }
                });
                Navigator.pop(context);
                _controller.clear();
              },
              child: Text('Pesquisar',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
          ],
        );
      },
    );
  }
}
