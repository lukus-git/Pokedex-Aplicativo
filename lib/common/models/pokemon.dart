class Pokemon {
  final String name; //nome do pokemon
  final String image; //imagem dele
  final List<String> type; //aqui vai ser o tipo do pokemon
  final int id; //sua identificacao
  final String num; //numero de cada pokemon

  //pega o valor de cada chave e tranforma em seu nome, id e etc...
  factory Pokemon.fromMap(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        image: json['img'],
        id: json['id'],
        num: json['num'],
        //aqui precisa garantir que ele e uma lista 
        type: (json['type'] as List).map((e) => e as String,).toList());
  }

  Pokemon({
    required this.name, 
    required this.image, 
    required this.id, 
    required this.num, 
    required this.type
  });
}
