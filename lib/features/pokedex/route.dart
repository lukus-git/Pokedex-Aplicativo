import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/screens/home/container/home_container.dart';

class PokedexRoute extends StatelessWidget {
  const PokedexRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/')
          // ignore: curly_braces_in_flow_control_structures
          return MaterialPageRoute(builder: (context) {
            return HomeContainer(repository: PokemonRepository(dio: Dio()));
          });
      },
    );
  }
}
