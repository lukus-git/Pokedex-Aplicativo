import 'package:flutter/material.dart';
import 'package:pokedex/common/error/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/home/pages/home_error.dart';
import 'package:pokedex/features/home/pages/home_loading.dart';
import 'package:pokedex/features/home/pages/home_screen.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key, required this.repository});
  final IPokemonRepository repository;

  @override
  Widget build(BuildContext context) {
    //usa o FutureBuilder para ficar observando a busca de Pokémons.
    return FutureBuilder<List<Pokemon>>(
      //qual busca queremos monitorar?
      future: repository.getAllPokemons(),

      //o que fazer em cada momento da busca?
      builder: (context, snapshot) {
        //a busca ainda não terminou.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeLoading(); // Mostra o carregando
        }

        //a busca terminou, mas veio com erro
        if (snapshot.hasError) {
          return HomeError(
            error: (snapshot.error as Failure).message!,
          );
        }

        //a busca terminou, e os dados chegaram!
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          //passa a lista de Pokémons (snapshot.data) para a tela principal
          return HomePage(list: snapshot.data!);
        }

        //fallback se alguma coisa estranho acontecer
        return const Center(
          child: Text('algo deu errado. Tente novamente'),
        );
      },
    );
  }
}
