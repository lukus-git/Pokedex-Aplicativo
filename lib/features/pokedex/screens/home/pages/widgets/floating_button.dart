import 'package:flutter/material.dart';

class AddPokemonFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddPokemonFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor, 
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}