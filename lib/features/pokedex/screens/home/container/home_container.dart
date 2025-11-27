import 'package:flutter/material.dart';
import 'package:pokedex/common/error/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/widgets/po_error.dart';
import 'package:pokedex/common/widgets/po_loading.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/add_pokemon_screen.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/home_page.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/app_manager.dart';
import 'package:provider/provider.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key, required this.repository, this.onItemTap});
  final IPokemonRepository repository;
  final Function(String, DetailArguments)? onItemTap;

  void _navigateAndAddNewPokemon(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPokemonScreen(), 
      ),
    );
    
    if (result != null && result is Map<String, dynamic>) {
      final newPokemon = Pokemon.fromMap(result); 
      
      // aqui vai obter o resultado do AppMenager
      // ignore: use_build_context_synchronously
      final appManager = Provider.of<AppManager>(context, listen: false); 
      // Chama o metodo no AppManager que vai adicionar e notificar o HomePage
      appManager.addPokemon(newPokemon); 

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${newPokemon.name} adicionado!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Acessa o AppManager, esse widget nao vai ser reconstruido quando o Manager mudar
    final appManager = Provider.of<AppManager>(context, listen: false); 

    return FutureBuilder<List<Pokemon>>(
      future: repository.getAllPokemons(),
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PoLoading(); 
        }

        if (snapshot.hasError) {
          return PoError(
            error: (snapshot.error as Failure).message!,
          );
        }

        // aqui verifica se a conexao, se deu certo entao vai mostrar a lista
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          if (appManager.pokemonList.isEmpty) {
             appManager.setInitialPokemons(snapshot.data!);
          }
          
          return HomePage(
            list: appManager.pokemonList, // passa a lista que ta no AppManager
            onItemTap: onItemTap,
            // passa a funçao de navegaçao para a HomePage
            onPokemonAdd: () => _navigateAndAddNewPokemon(context), 
          );
        }

        return const Center(
          child: Text('algo deu errado. Tente novamente'),
        );
      },
    );
  }
}