import 'package:flutter/material.dart'; // Importa a biblioteca Flutter para criar interfaces gráficas
import 'package:http/http.dart'
    as http; // Importa a biblioteca http para fazer requisições HTTP
import 'dart:convert'; // Importa a biblioteca para converter dados JSON
import 'pokemon.dart'; // Importa o modelo Pokémon que criamos em outro arquivo

// Função principal que inicializa o aplicativo
void main() {
  runApp(const MeuApp()); // Executa o widget MeuApp como a raiz do aplicativo
}

// Widget principal do aplicativo
class MeuApp extends StatelessWidget {
  // Construtor da classe MeuApp
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Método build constrói a interface do widget
    return MaterialApp(
      title: 'Pokémon App', // Define o título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors
            .blue, // Define o tema do aplicativo com uma cor primária azul
      ),
      home: const MinhaPaginaInicial(), // Define o widget inicial do aplicativo
    );
  }
}

// Página inicial do aplicativo
class MinhaPaginaInicial extends StatefulWidget {
  // Construtor da classe MinhaPaginaInicial
  const MinhaPaginaInicial({super.key});

  @override
  MinhaPaginaInicialState createState() =>
      MinhaPaginaInicialState(); // Cria o estado associado a este widget
}

// Estado associado ao StatefulWidget MinhaPaginaInicial
class MinhaPaginaInicialState extends State<MinhaPaginaInicial> {
  final TextEditingController _controller =
      TextEditingController(); // Controlador para o campo de texto
  Pokemon? _pokemon; // Variável para armazenar o Pokémon buscado
  bool _isLoading = false; // Variável para controlar o estado de carregamento

  // Função para mostrar Snackbar com mensagens de erro ou alertas
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), // Define a mensagem a ser exibida no Snackbar
        duration: const Duration(seconds: 3), // Define a duração do Snackbar
      ),
    );
  }

  // Função para buscar os dados do Pokémon da API
  Future<void> _buscarPokemon() async {
    final String id = _controller.text
        .trim(); // Obtém o ID digitado pelo usuário e remove espaços extras

    if (id.isEmpty) {
      // Verifica se o ID está vazio
      _showSnackbar(
          'Por favor, digite um ID válido'); // Mostra uma mensagem de erro
      return; // Sai da função se o ID estiver vazio
    }

    setState(() {
      _isLoading = true; // Define que o aplicativo está carregando
      _pokemon = null; // Limpa o Pokémon anterior, se houver
    });

    try {
      final resposta =
          await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
      // Faz uma requisição GET para a API do Pokémon com o ID fornecido

      if (resposta.statusCode == 200) {
        // Verifica se a resposta foi bem-sucedida
        final dados =
            json.decode(resposta.body); // Converte a resposta JSON em um mapa

        setState(() {
          _pokemon = Pokemon.fromJson(
              dados); // Cria uma instância de Pokémon a partir dos dados JSON
        });
      } else {
        _showSnackbar(
            'Pokémon não encontrado'); // Mostra uma mensagem de erro se o Pokémon não for encontrado
      }
    } catch (e) {
      _showSnackbar(
          'Erro ao buscar dados do Pokémon'); // Mostra uma mensagem de erro se ocorrer uma exceção
    } finally {
      setState(() {
        _isLoading = false; // Define que o carregamento terminou
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // O método build constrói a interface gráfica do widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon App'), // Título do aplicativo na AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Adiciona espaçamento ao redor do conteúdo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Faz com que os filhos preencham toda a largura disponível
          children: <Widget>[
            TextField(
              controller: _controller, // Controlador para o campo de texto
              decoration: const InputDecoration(
                labelText:
                    'Digite o ID do Pokémon', // Texto de dica dentro do campo de texto
                border:
                    OutlineInputBorder(), // Adiciona uma borda ao redor do campo de texto
              ),
              keyboardType: TextInputType
                  .number, // Define o tipo de teclado como numérico
            ),
            const SizedBox(
                height: 10), // Adiciona um espaçamento vertical de 10 pixels
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : _buscarPokemon, // Define a ação ao pressionar o botão
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Buscar Pokémon'),
              // Se estiver carregando, mostra um indicador de progresso; caso contrário, mostra o texto do botão
            ),
            const SizedBox(
                height: 20), // Adiciona um espaçamento vertical de 20 pixels
            if (_pokemon != null) // Verifica se há um Pokémon carregado
              Card(
                // Cria um cartão para exibir os dados do Pokémon
                child: Column(
                  children: <Widget>[
                    Image.network(_pokemon!
                        .urlImagem), // Exibe a imagem do Pokémon usando a URL
                    Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Adiciona espaçamento ao redor do texto
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _pokemon!.nome
                                .toUpperCase(), // Exibe o nome do Pokémon em maiúsculas
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold), // Define o estilo do texto
                          ),
                          const SizedBox(
                              height:
                                  8), // Adiciona um espaçamento vertical de 8 pixels
                          Text(
                            'ID: ${_pokemon!.id}', // Exibe o ID do Pokémon
                            style: const TextStyle(
                                fontSize: 16), // Define o estilo do texto
                          ),
                          const SizedBox(
                              height:
                                  8), // Adiciona um espaçamento vertical de 8 pixels
                          Text(
                            'Tipos: ${_pokemon!.tipos.join(', ')}', // Exibe os tipos do Pokémon
                            style: const TextStyle(
                                fontSize: 16), // Define o estilo do texto
                          ),
                          const SizedBox(
                              height:
                                  8), // Adiciona um espaçamento vertical de 8 pixels
                          Text(
                            'Altura: ${_pokemon!.altura} dm', // Exibe a altura do Pokémon
                            style: const TextStyle(
                                fontSize: 16), // Define o estilo do texto
                          ),
                          const SizedBox(
                              height:
                                  8), // Adiciona um espaçamento vertical de 8 pixels
                          Text(
                            'Peso: ${_pokemon!.peso} hg', // Exibe o peso do Pokémon
                            style: const TextStyle(
                                fontSize: 16), // Define o estilo do texto
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
