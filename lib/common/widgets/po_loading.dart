import 'package:flutter/material.dart';
//aqui e o arquivo padrao de loading

class PoLoading extends StatelessWidget {
  const PoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
