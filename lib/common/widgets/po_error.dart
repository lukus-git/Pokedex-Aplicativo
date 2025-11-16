import 'package:flutter/material.dart';
//aqui e o arquivo padrão de erro assim fica melhor e mais organizado

class PoError extends StatelessWidget {
  const PoError({super.key, this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text(error ?? 'erro durante a operação') ,
      ),
    );
  }
}
