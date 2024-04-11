// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login/view/itens_lista.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/menu_lista.dart';
import '../model/lista_itens.dart';
import 'dart:convert';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  //declaração da lista dinâmica de contatos
  List<Menu_Lista> lista = [];

  //CAiXA DE DIALOGO PRINCIPAL
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
                editarLista(
                    context, index); // Abrir caixa de diálogo para editar
              },
              child: Text('Editar',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                removerItem(index); // Remover o item selecionado
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

  @override
  /*void initState() {
    lista = Menu_Lista.gerarLista();
    super.initState();
  }*/
  void initState() {
    super.initState();
    carregarLista(); // Carregar a lista ao iniciar a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text('Suas Listas'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Exibir caixa de diálogo de ajuda
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Ajuda'),
                    content: Text(
                      '\n--> Essa tela contem suas listas de organização!'
                      '\n--> Voce pode adiciona listas ao clicar no botão "+" '
                      'no canto inferior direito. '
                      '\n--> Você também pode excluir ou editar qualquer lista ao'
                      ' precionar-las!'
                      '\n--> Depois de criar suas listas clique nelas para visualizar o conteudo. '
                      'Voce será direcionado para outra tela com os itens de cada lista! ',
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
                          style: TextStyle(
                            fontSize: 18,
                          ),
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
        // ListView
        child: ListView.builder(
          //Quantidade de itens
          itemCount: lista.length,
          //Aparência de cada item
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                leading: Icon(Icons.shopping_cart_checkout),
                title: Text(
                  lista[index].nome,
                  style: TextStyle(
                    fontSize: 18, // Defina o tamanho da fonte aqui
                    fontWeight:
                        FontWeight.normal, // Opcional: ajuste o peso da fonte
                  ),
                ),
                hoverColor: Colors.red.shade50,
                onTap: () {
                  //clicar no intem
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        //retprnar os itens da lista
                        return Itens_ListaView(lista: lista[index].itens);
                      },
                    ),
                  );
                },

                //remover um item da lista
                onLongPress: () {
                  setState(() {
                    //chama a caixa dialogo pra selecionar o excluir e digitar
                    caixaDialogo(context, index);
                    salvarLista();
                    //salva a lista depois das alterações
                  });
                },
              ),
            );
          },
        ),
      ),

      //Botão flutuante (adicionar)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adicionarLista(context);
        },
        backgroundColor: Colors.blueGrey.shade200,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  adicionarLista(BuildContext context) async {
    final novalista = await showDialog<String>(
      context: context,
      builder: (context) {
        String nome = '';
        return AlertDialog(
          title: Text('Adicionar Nova Lista'),
          content: TextField(
            onChanged: (value) {
              nome = value;
            },
            decoration: InputDecoration(hintText: 'Nome da lista'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(nome);
              },
              child: Text(
                'Adicionar',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );

    // se o nome não estiver vazio e não for nulo adiciona a lista
    if (novalista != null && novalista.isNotEmpty) {
      setState(() {
        lista.add(Menu_Lista(nome: novalista, itens: []));
      });
      salvarLista();
    }
  }

  removerItem(int index) {
    setState(() {
      lista.removeAt(index);
    });
    salvarLista();
  }

  editarLista(BuildContext context, int index) async {
    final novoNomeLista = await showDialog<String>(
      context: context,
      builder: (context) {
        String novoNome = lista[index].nome;
        return AlertDialog(
          title: const Text('Editar Nome da Lista'),
          content: TextField(
            onChanged: (value) {
              novoNome = value;
            },
            decoration: InputDecoration(hintText: lista[index].nome),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  //passar o novo nome e manster os itens da lista alterada
                  lista[index] =
                      Menu_Lista(nome: novoNome, itens: lista[index].itens); //
                });
                Navigator.of(context).pop(novoNome);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
//se o nome novo nome não for nulo e nao estiver fazio e não for igual ao antigo ele salva
    if (novoNomeLista != null &&
        novoNomeLista.isNotEmpty &&
        novoNomeLista != lista[index].nome) {
      salvarLista();
    }
  }

  //carrega itens de cada lista
  carregarLista() async {
    final prefs = await SharedPreferences.getInstance();
    final listaString = prefs.getStringList('lista') ?? [];
    List<Menu_Lista> listaCarregada = [];
    for (var item in listaString) {
      List<Itens_Lista> itens = await _carregarItensLista(item);
      listaCarregada.add(Menu_Lista(nome: item, itens: itens));
    }

    setState(() {
      if (lista.isEmpty) {
        lista = listaCarregada;
        if (lista.isEmpty) {
          lista.addAll(Menu_Lista.gerarLista());
        }
      }
    });
  }

  salvarLista() async {
    final prefs = await SharedPreferences.getInstance();
    final listaString = lista.map((item) => item.nome).toList();
    prefs.setStringList('lista', listaString);
  }

  Future<List<Itens_Lista>> _carregarItensLista(String listaNome) async {
    final prefs = await SharedPreferences.getInstance();
    // Obtem a lista de strings associada ao nome da lista como parâmetro
    final listaString = prefs.getStringList(listaNome) ?? [];
    // Mapea cada string da lista para um objeto Itens_Lista e retornando a lista resultante
    return listaString
        .map((item) => Itens_Lista.fromJson(jsonDecode(item)))
        .toList();
  }
}
