import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/type_widg.dart';

class PokemonItemWidg extends StatelessWidget {
  const PokemonItemWidg({super.key, required this.pokemon, this.onTap});
  final Pokemon pokemon;
  final Function(String, DetailArguments)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!('/details', DetailArguments(pokemon: pokemon)),
      child: Container(
        decoration: BoxDecoration(
          color: pokemon.baseColor!.withOpacity(0.8),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      pokemon.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    '#${pokemon.num}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(children: pokemon.type.map((e) => TypeWidg(name: e)).toList()),
                  Flexible(child: Image.network(pokemon.image)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
