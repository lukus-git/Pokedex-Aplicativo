import 'package:flutter/material.dart';
import 'package:pokedex/common/error/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/widgets/po_error.dart';
import 'package:pokedex/common/widgets/po_loading.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/details_page.dart';


//tudo abaixo foi explicado no ---> home_container.dart <---

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
  late Future<List<Pokemon>> _future;

  Pokemon? _pokemon;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.6, initialPage: widget.arguments.index);
    _future = widget.repository.getAllPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return PoLoading();
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            _pokemon ??= widget.arguments.pokemon;
            return DetailPage(
              pokemon: _pokemon!,
              list: snapshot.data!,
              onBack: widget.onBack,
              controller: _controller,
              onChangePokemon: (Pokemon value) {
                setState(() {
                  _pokemon = value;
                });
              },
            );
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
