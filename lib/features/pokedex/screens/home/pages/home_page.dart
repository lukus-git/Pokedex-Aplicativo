import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/app_manager.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/pokemon_item_widg.dart';

import 'package:provider/provider.dart';
// 🚨 NOVO IMPORT: Importe o seu widget de botão flutuante
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/floating_button.dart';

class HomePage extends StatelessWidget {
  // A funçao que o HomeContainer vai passar para chamar a tela de adição de pokemon
  final VoidCallback? onPokemonAdd;

  const HomePage({
    super.key,
    required this.list,
    this.onItemTap,
    this.onPokemonAdd,
  });

  final List<Pokemon> list;
  final Function(String, DetailArguments)? onItemTap;

  @override
  Widget build(BuildContext context) {
    // Acessa o AppManager para gerenciar tema e lista
    final appManager = Provider.of<AppManager>(context);
    final isDarkMode = appManager.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : const Color.fromARGB(255, 173, 213, 233),
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Pokedex',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 26,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () {
                  appManager.toggleTheme(!isDarkMode);
                },
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDarkMode ? Colors.blueGrey : Colors.black,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24, top: 20,bottom: 0  ),
        child: GridView.count(
          crossAxisSpacing: 24,
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          //aqui ta mapeando a lista e aparecendo os itens que eu quero que apareça
          children: list
              .map(
                (e) => PokemonItemWidg(
                  pokemon: e,
                  onTap: onItemTap,
                  index: list.indexOf(e),
                ),
              )
              .toList(),
        ),
      ),

      // botao de + parfa adicionar o pokemon
      floatingActionButton: AddPokemonFloatingButton(
        onPressed: () {
          // Chama a função passada pelo HomeContainer
          onPokemonAdd?.call();
        },
      ),
    );
  }
}
