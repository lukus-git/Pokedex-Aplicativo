import 'package:flutter/material.dart';
// ⚠️ ATENÇÃO: Corrija o caminho de importação do seu modelo Pokemon
import 'package:pokedex/common/models/pokemon.dart'; 

class DetailInfoWidget extends StatelessWidget {
  // 🚀 ADICIONE ESTA PROPRIEDADE
  final Pokemon pokemon;

  // 🚀 ADICIONE O CONSTRUTOR COM O REQUERIMENTO DO POKEMON
  const DetailInfoWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  dados do pokemon altura, peso, ovo) 
            _buildBasicDataRow(),
            const Divider(height: 30),

            // tipos do pokemon 
            _buildTypesSection(context),
            const Divider(height: 30),

            //  fraquzas do pokemon
            _buildWeaknessesSection(context),

            // Adicione aqui a seção de Evoluções se quiser expandir
          ],
        ),
      ),
    );
  }
  
  
  // esse widget serve para deixar os dados mias bonitas 
  Widget _buildDataPoint(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  //os widgets de baixo servem para deixar as informaçoes separadas 

  //informacao da altura, peso, e o ovo
  Widget _buildBasicDataRow() {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDataPoint("Altura", pokemon.height),
          _buildDataPoint("Peso", pokemon.weight),
          _buildDataPoint("Ovo", pokemon.egg),
        ],
      );
  }

  //informacao dos tipos do pokemon
  Widget _buildTypesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tipos",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0, 
          runSpacing: 4.0,
          children: pokemon.type.map((type) => Chip(
            label: Text(
              type,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: pokemon.baseColor,
          )).toList(),
        ),
      ],
    );
  }
  
  // informacao das fraquezas do pokemon
  Widget _buildWeaknessesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Fraquezas",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: pokemon.weaknesses.map((weakness) => Chip(
            label: Text(
              weakness,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red.withOpacity(0.7),
          )).toList(),
        ),
      ],
    );
  }
}