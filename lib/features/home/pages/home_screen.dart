import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

//aqui vai ser a tela inicial (home)

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.list});
  final List<Pokemon> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
