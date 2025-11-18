import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/pokemon_item_widg.dart';

//aqui vai ser a tela inicial (home)

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.list, this.onItemTap});
  final List<Pokemon> list;
  final Function(String, DetailArguments)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Pokedex',
            style: TextStyle(color: Colors.black,
            fontSize: 26),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.count(
          crossAxisSpacing: 24,
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          children: list
              .map((e) => PokemonItemWidg(
                    pokemon: e,
                    onTap: onItemTap,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
