import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_flutter/main.dart'; // Caminho correto para o arquivo main.dart
void main() {
  testWidgets('Verifica o título do aplicativo', (WidgetTester tester) async {
    // Constrói o widget e espera até que ele esteja estável
    await tester.pumpWidget(const MeuApp());

    // Verifica se o título do aplicativo está presente
    expect(find.text('Pokémon App'), findsOneWidget);
  });

  testWidgets('Verifica a funcionalidade do botão de busca', (WidgetTester tester) async {
    // Constrói o widget e espera até que ele esteja estável
    await tester.pumpWidget(const MeuApp());

    // Encontra o TextField e insere um texto
    await tester.enterText(find.byType(TextField), '25');

    // Encontra o ElevatedButton e clica nele
    await tester.tap(find.byType(ElevatedButton));

    // Aguarda o próximo frame para verificar o estado de carregamento
    await tester.pump();

    // Verifica se o CircularProgressIndicator aparece enquanto está carregando
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Aguarda um período para simular a requisição de rede
    await tester.pump(const Duration(seconds: 3));

    // Verifica se o CircularProgressIndicator desapareceu e o Card com o Pokémon aparece
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(Card), findsOneWidget);
  });
}