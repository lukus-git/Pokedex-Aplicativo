import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/home/container/home_container.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme:  ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:HomeContainer(
        repository: PokemonRepository(  ),
      ),
    );
  }
}
