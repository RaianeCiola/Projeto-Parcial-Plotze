
class Itens_Lista {
  final String nome;
  final String quant;
  bool comprado;

  Itens_Lista({required this.nome, required this.quant, this.comprado = false});

  // Método factory para criar uma instância de Itens_Lista a partir de um mapa
  factory Itens_Lista.fromJson(Map<String, dynamic> json) {
    return Itens_Lista(
      nome: json['nome'],
      quant: json['quant'],
      comprado: json['comprado'] ?? false,
    );
  }

  // Método para converter um objeto Itens_Lista em um mapa
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quant': quant,
      'comprado': comprado,
    };
  }

  // Geração de lista dinâmica de itens para teste
  static List<Itens_Lista> gerarLista() {
    List<Itens_Lista> lista = [];
    lista.add(Itens_Lista(nome: 'Arroz', quant: '3kg'));
    lista.add(Itens_Lista(nome: 'Feijão', quant: '1kg'));
    lista.add(Itens_Lista(nome: 'Açúcar', quant: '5kg'));
    lista.add(Itens_Lista(nome: 'Beterraba', quant: '3'));
    lista.add(Itens_Lista(nome: 'Carne Moida', quant: '500g'));
    lista.add(Itens_Lista(nome: 'Macarrão', quant: '1 pacote'));
    lista.add(Itens_Lista(nome: 'Batata', quant: '1 kg'));
    lista.add(Itens_Lista(nome: 'Alface', quant: '1 maço'));
    lista.add(Itens_Lista(nome: 'Laranja', quant: '5'));
    lista.add(Itens_Lista(nome: 'Peito de Frango', quant: '2 kg'));
    lista.add(Itens_Lista(nome: 'cenoura', quant: '3'));
    return lista;
  }
}
