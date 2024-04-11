
import 'package:login/model/lista_itens.dart';


class Menu_Lista {
  final String nome;
  List<Itens_Lista> itens; // Lista de itens associada a esta lista

  Menu_Lista({required this.nome, List<Itens_Lista>? itens})
      : itens = itens ?? [];

  static List<Menu_Lista> gerarLista() {
    List<Menu_Lista> lista = [];
    // Adiciona as listas estáticas
    lista.add(Menu_Lista(nome: 'Lista semanal', itens: Itens_Lista.gerarLista()));
    lista.add(Menu_Lista(nome: 'Churrasco', itens: [])); // Lista vazia
    return lista;
  }

}