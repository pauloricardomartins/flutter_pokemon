import 'package:flutter_test/flutter_test.dart';
import 'package:app_flutter/pokemon.dart'; // Importe o arquivo que você deseja testar

void main() {
  group('Pokemon Model Tests', () {
    test('fromJson creates a valid Pokemon object', () {
      // JSON de exemplo para o teste
      final json = {
        'id': 25,
        'name': 'pikachu',
        'sprites': {'front_default': 'https://pokeapi.co/media/sprites/pokemon/25.png'}
      };
      // Cria um objeto Pokemon a partir do JSON
      final pokemon = Pokemon.fromJson(json);

      // Verifica se os valores são atribuídos corretamente
      expect(pokemon.id, 25);
      expect(pokemon.nome, 'pikachu');
      expect(pokemon.urlImagem, 'https://pokeapi.co/media/sprites/pokemon/25.png');
    });
  });
}
