import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/home/pages/home_loading.dart';
import 'package:pokedex/features/home/pages/home_screen.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key, required this.repository});
  final IPokemonRepository repository;

  // variável que receberá o Future que vai ser observado.
  

  @override
  Widget build(BuildContext context) {
    // Usa o FutureBuilder para reconstruir a UI automaticamente
    // quando o estado do Future (listFuture) mudar.
    return FutureBuilder<List<Pokemon>>(
      // Passa o Future que será monitorado pelo widget.
      future:  repository.getAllPokemons(),  
      // A função builder é chamada sempre que o estado do Future muda.
      // O `snapshot` contém o estado atual, dados ou erro do Future.
      builder: (context, snapshot) {
        // 1. TRATAMENTO DO ESTADO DE CARREGAMENTO (LOADING)
        // Se a conexão ainda estiver em espera (waiting)...
        if (snapshot.connectionState == ConnectionState.waiting) {
          // ...retorna o widget de loading para informar o usuário.
          return const HomeLoading();
        }

        // 2. TRATAMENTO DO ESTADO DE ERRO
        // Se o Future terminou (done) e contém um erro (hasError)...
        if (snapshot.hasError) {
          // ...retorna um widget que exibe a mensagem de erro.
          return Center(
            child: Text(
              'Erro: ${snapshot.error.toString()}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // 3. TRATAMENTO DO ESTADO DE SUCESSO
        // Se o Future terminou (done) e contém dados (hasData)...
        if (snapshot.hasData) {
          // ...retorna a tela principal, passando a lista de Pokémon carregada.
          // O "!" (bang operator) é usado aqui pois snapshot.hasData garante que .data não é nulo.
          return HomePage(list: snapshot.data!);
        }

        // 4. RETORNO PADRÃO (SAFETY NET)
        // Se nenhum dos casos acima for satisfeito (ex: done sem dados)...
        // ...retorna um widget de fallback.
        return const Center(
          child: Text('Nenhum Pokémon encontrado. Tente novamente.'),
        );
      },
    );
  }
}
