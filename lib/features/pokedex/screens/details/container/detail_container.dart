import 'package:flutter/material.dart';
import 'package:pokedex/common/error/failure.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/widgets/po_error.dart';
import 'package:pokedex/common/widgets/po_loading.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/details_page.dart';

//tudo abaixo foi explicado no ---> home_container.dart <---

class DetailArguments {
  DetailArguments({required this.name});
  final String name;
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    super.key,
    required this.repository,
    required this.arguments,
    this.onItemTap,
  });
  final IPokemonRepository repository;
  final DetailArguments arguments;
  final Function(String, DetailArguments)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: repository.getAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return PoLoading();
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return DetailPage(name: arguments.name, list: snapshot.data!,);
          }

          if (snapshot.hasError) {
            return PoError(error: (snapshot.error as Failure).message!);
          }

          return Center(
            child: Text('algo deu errado, tente novamente'),
          );
        });
  }
}
