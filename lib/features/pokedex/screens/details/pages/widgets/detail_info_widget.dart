import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:provider/provider.dart'; 
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/app_manager.dart'; 


// a parte do tema escuro fiz com ajuda de videos do youtube e IA
class DetailInfoWidget extends StatelessWidget {
  final Pokemon pokemon;
  const DetailInfoWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    // aqui ta acessando o gerenciador de temas
    final appManager = Provider.of<AppManager>(context);
    final isDarkMode = appManager.themeMode == ThemeMode.dark;

    // aqui define as cores
    final containerColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final primaryTextColor = isDarkMode ? Colors.white : Colors.black;
    final detailTextColor = isDarkMode ? Colors.grey[400] : Colors.grey;
    final dividerColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];

    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // aqui  ta passando as cores 
            _buildBasicDataRow(detailTextColor!, primaryTextColor),
            Divider(height: 30, color: dividerColor),

            _buildTypesSection(primaryTextColor),
            Divider(height: 30, color: dividerColor),

            _buildWeaknessesSection(primaryTextColor),
          ],
        ),
      ),
    );
  }

  
  Widget _buildDataPoint(String title, String value, Color titleColor, Color valueColor) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: titleColor),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: valueColor),
        ),
      ],
    );
  }

 //aqui e a sessao de informaçoes do pokemon
  Widget _buildBasicDataRow(Color detailTextColor, Color primaryTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDataPoint("Altura", pokemon.height, detailTextColor, primaryTextColor),
        _buildDataPoint("Peso", pokemon.weight, detailTextColor, primaryTextColor),
        _buildDataPoint("Ovo", pokemon.egg, detailTextColor, primaryTextColor),
      ],
    );
  }

  // aqui e a sessao dos tipos do pokemon
  Widget _buildTypesSection(Color primaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tipos",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryTextColor),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: pokemon.type
              .map((type) => Chip(
                    label: Text(
                      type,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: pokemon.baseColor,
                  ))
              .toList(),
        ),
      ],
    );
  }

  // aqui e a sessao de fraquezas do pokemon
  Widget _buildWeaknessesSection(Color primaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fraquezas",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryTextColor),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: pokemon.weaknesses
              .map((weakness) => Chip(
                    label: Text(
                      weakness,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.blueGrey
                  ))
              .toList(),
        ),
      ],
    );
  }
}
