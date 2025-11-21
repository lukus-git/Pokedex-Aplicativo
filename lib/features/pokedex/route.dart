import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/container/home_container.dart';

class PokedexRoute extends StatelessWidget {
  const PokedexRoute({super.key, required this.repository, this.onItemTap});
  final PokemonRepository repository;
  final Function(String)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      //settings serve para pegar o nome da rota e levar para o destino da pagina
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) {
              return HomeContainer(
                repository: repository,
                onItemTap: (route, arguments) {
                  Navigator.of(context).pushNamed(route, arguments: arguments);
                },
              );
            });
          case '/details':
            return MaterialPageRoute(builder: (context) {
              return DetailContainer(
                repository: repository,
                arguments: (settings.arguments as DetailArguments),
                onBack: () => Navigator.of(context).pop(),
              );
            });
        }
        return null;

        /* ---> switch fica mais bonito <---

        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) {
            return HomeContainer(repository: repository);
          });
        }

        if (settings.name == '/details') {
          return MaterialPageRoute(builder: (context) {
            return HomeContainer(repository: repository);
          });
        }
        */
      },
    );
  }
}
