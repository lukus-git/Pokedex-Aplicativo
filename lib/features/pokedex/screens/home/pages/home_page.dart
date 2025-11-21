import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/pokemon_item_widg.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/theme_manager.dart';
import 'package:provider/provider.dart';  

// aqui vai ser a tela inicial (home)

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.list, this.onItemTap});
  final List<Pokemon> list;
  final Function(String, DetailArguments)? onItemTap;

  @override
  Widget build(BuildContext context) {
    // 2. OBTÉM O GERENCIADOR DE TEMA
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // 💡 MELHORIA: A cor de fundo da AppBar deve ser controlada pelo ThemeData no main.dart
        // Por enquanto, vou remover o 'backgroundColor: Colors.white' para que o tema do MaterialApp atue aqui.
        // Se você quiser manter o fundo branco no modo claro, defina-o no theme do MaterialApp.
        
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Pokedex',
            // 💡 MELHORIA: A cor do texto do título deve ser controlada pelo 'foregroundColor' da AppBarTheme
            // do ThemeData (para alternar automaticamente entre preto/branco).
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black, // Adaptação manual temporária
              fontSize: 26,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            // 🚀 SUBSTITUIÇÃO DO BOTÃO 'MENU' PELO BOTÃO DE 'TEMA'
            child: IconButton(
                onPressed: () {
                  // CHAMA A LÓGICA DE ALTERNÂNCIA NO MANAGER
                  themeManager.toggleTheme(!isDarkMode);
                },
                icon: Icon(
                  // ÍCONE DINÂMICO: Sol (claro) se estiver escuro, Lua (escuro) se estiver claro
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDarkMode ? Colors.yellow : Colors.black, // Cor do ícone
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
    );
  }
}