import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

class AppManager extends ChangeNotifier {
  // --- Lógica do Tema ---
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  
  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;

  // injeta a lista inicial chamada pelo HomeContainer
  void setInitialPokemons(List<Pokemon> initialList) {
    // Evita carregar os dados novamente se já estiverem feitos
    if (_pokemonList.isEmpty) {
      _pokemonList = initialList;
    }
  }

  // aqui adiciona o novo Pokémon que é chamadado pelo HomeContainer depois de preencher o formulario
  void addPokemon(Pokemon newPokemon) {
    _pokemonList.add(newPokemon);
    // aqui vai notificar o HomePage para exibir o novo Pokémon que foi adicionado
    notifyListeners();
  }
}
