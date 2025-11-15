import 'package:flutter/material.dart';

//essa é a tela de erro, caso der algum erro o app cai nessa tela

class HomeError extends StatelessWidget {
  const HomeError({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}
