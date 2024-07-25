class Pokemon {
  final int id;
  final String nome;
  final String urlImagem;
  final List<String> tipos;
  final int altura;
  final int peso;

  // Construtor da classe Pokémon
  Pokemon({
    required this.id,
    required this.nome,
    required this.urlImagem,
    required this.tipos,
    required this.altura,
    required this.peso,
  });

  // Factory constructor para criar uma instância de Pokémon a partir de um JSON
  // Baseado no Json da API :
  // {
  //     "id": 25,
  //     "name": "pikachu",
  //     "sprites": {
  //       "front_default": "https://pokeapi.co/media/sprites/pokemon/25.png"
  //     },
  //     "types": [
  //       {
  //         "type": {
  //           "name": "electric"
  //         }
  //       }
  //     ],
  //     "height": 4,
  //     "weight": 60
  // }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Extrai os tipos do Pokémon
    List<String> tipos = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    return Pokemon(
      id: json['id'],
      nome: json['name'],
      urlImagem: json['sprites']['front_default'],
      tipos: tipos,
      altura: json['height'],
      peso: json['weight'],
    );
  }
}
