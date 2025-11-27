import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/widgets/po_loading.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/details_page.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/app_manager.dart'; 


class DetailArguments {
DetailArguments({
 required this.pokemon,
 this.onBack,
 required this.index,
});
final Pokemon pokemon;
final VoidCallback? onBack;
final int index;
}

class DetailContainer extends StatefulWidget {
const DetailContainer({
 super.key,
 required this.repository,
 required this.arguments,
 this.onItemTap,
 this.onBack,
});
final IPokemonRepository repository;
final DetailArguments arguments;
final Function(String, DetailArguments)? onItemTap;
final VoidCallback? onBack;

@override
State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
late PageController _controller;

Pokemon? _pokemon;

@override
void initState() {
    // 1. Acessa o AppManager (listen: false é seguro em initState)
    // O AppManager precisa ser acessado através do Provider antes do super.initState()
    // mas em Stateless/Stateful widgets que usam Provider, é comum usar addPostFrameCallback
    // ou acessar diretamente o Provider aqui, pois o context está disponível.
    
    // 🚨 AJUSTE CRÍTICO: Buscar o Pokémon completo da lista do AppManager
    // Usamos Provider.of(context, listen: false) para buscar os dados de forma segura.
    final appManager = Provider.of<AppManager>(context, listen: false);
    final list = appManager.pokemonList;
    final initialIndex = widget.arguments.index;

    // Garante que o índice existe na lista antes de acessar
    if (initialIndex >= 0 && initialIndex < list.length) {
        // 🚨 INICIALIZA O _POKEMON COM A VERSÃO COMPLETA DA LISTA
        _pokemon = list[initialIndex];
    } else {
        // Fallback: usa o objeto passado (pode estar incompleto)
        _pokemon = widget.arguments.pokemon; 
    }
    
    // Inicializa o PageController com o índice correto
  _controller = PageController(viewportFraction: 0.6, initialPage: initialIndex);

 super.initState();
}

@override
Widget build(BuildContext context) {
  
  final appManager = Provider.of<AppManager>(context); 
  final list = appManager.pokemonList;
  
  // se a lista de pokemons nao carregar mostra o loading.
  if (list.isEmpty || _pokemon == null) {
    return const PoLoading(); 
  }
  
  // retorna a lista atualizada
return DetailPage(
    
   pokemon: _pokemon!, 
   list: list, 
   onBack: widget.onBack,
   controller: _controller,
   onChangePokemon: (Pokemon value) {
        // atualiza o estado local quando o PageView desliza
     setState(() {
       _pokemon = value;
     });
   },
);
}
}