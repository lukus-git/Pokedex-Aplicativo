import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/app_manager.dart';
import 'package:provider/provider.dart'; // 1. NOVO IMPORT
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/route.dart';

void main() {
  runApp(
    //aqui vai ver se qual tema que ta, esuro ou claro
    ChangeNotifierProvider(
      create: (context) => AppManager(), // Cria uma instancia do gerenciador
      child: const PokedexApp(), 
    ),
  );
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final themeManager = Provider.of<AppManager>(context);

    //modo claro
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
    );

    //modo escuro
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      //aqui vai ser a cor base o app que vai ser vemrlho
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent, brightness: Brightness.dark),
      scaffoldBackgroundColor: Colors.grey[900],
    );

    return MaterialApp(
      title: 'Pokedex',

      // nao mostrar mais aquele icone chato e feio de debug
      debugShowCheckedModeBanner: false,

      // configuraçao do tema
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode, // Define o modo atual claro ou escuro
      home: PokedexRoute(repository: PokemonRepository(dio: Dio())),
    );
  }
}
 