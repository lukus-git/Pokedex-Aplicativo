import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';

//aqui vai ser a tela inicial (home)

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.list, this.onItemTap});
  final List<Pokemon> list;
  final Function(String, DetailArguments)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            //aqui estou passando o nome dos pokemons em forma de lista
            title: Text(list[index].name),
            //ao clicar em alugum nome da lista vai para a pagina de detalhes
            onTap: () => onItemTap!('/details', DetailArguments(name: list[index].name),),
          );
        },
      ), 
    );
  }
}
