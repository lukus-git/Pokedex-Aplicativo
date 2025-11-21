import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';

class DetailAppbarWidget extends StatelessWidget {
  const DetailAppbarWidget({super.key, required this.pokemon, this.onBack, required this.isOnTop});
  final Pokemon pokemon;
  final VoidCallback? onBack;
  final bool isOnTop;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: pokemon.baseColor,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(Icons.arrow_circle_left),
      ),
      centerTitle: false,
      title: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isOnTop ? 0 : 1,

            child: Text(pokemon.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
    );
  }
}
