import 'package:flutter/material.dart';

class AddPokemonScreen extends StatefulWidget {
  const AddPokemonScreen({super.key});
  @override
  State<AddPokemonScreen> createState() => _AddPokemonScreenState();
}

class _AddPokemonScreenState extends State<AddPokemonScreen> {
  // Controladores das informaçoes dos pokemons
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _numController = TextEditingController(); 
  final _typeController = TextEditingController(); 
  final _weaknessesController = TextEditingController(); 
  final _heightController = TextEditingController(text: '1.0m');
  final _weightController = TextEditingController(text: '1.0kg');
  final _eggController = TextEditingController(text: 'Desconhecido'); 

  final _imageController = TextEditingController(
      text: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'); 


  //os dados abaixo fiz com ajuda de IA pois nao achava em lugar alugum como fazer
  void _savePokemon() {
    if (_nameController.text.isEmpty || _idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome e ID são obrigatórios.')),
      );
      return;
    }
    
    // aqui vai ser mapeado os dados
    final newPokemonData = {
      'id': int.tryParse(_idController.text) ?? 9999, 
      'name': _nameController.text,
      // se num tiver vazio usa o ID preenchido com zeros
      'num': _numController.text.isEmpty ? _idController.text.padLeft(3, '0') : _numController.text,
      'type': _typeController.text.split(',').map((e) => e.trim()).toList(),
      'weaknesses': _weaknessesController.text.split(',').map((e) => e.trim()).toList(),
      'img': _imageController.text, 
      'height': _heightController.text, 
      'weight': _weightController.text, 
      'egg': _eggController.text, 
    };
    
    // Retorna os dados para o HomeContainer que estava esperando
    Navigator.of(context).pop(newPokemonData); 
  }
  
  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Novo Pokémon')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dados básicos
            _buildTextField('Nome', _nameController),
            _buildTextField('ID do pokemon(Numérico, >2000)', _idController, keyboardType: TextInputType.number),
            _buildTextField('Número do pokemon(Pokédex)', _numController),
            _buildTextField('Tipos do pokemon(separar por virgula)', _typeController),
            _buildTextField('Fraquezas do pokemon (separar por virgula)', _weaknessesController),
            
            const SizedBox(height: 10),
            const Divider(),
            const Text('Detalhes de Batalha', style: TextStyle(fontWeight: FontWeight.bold)),

            _buildTextField('Altura (ex: 0.7m)', _heightController),
            _buildTextField('Peso (ex: 6.9kg)', _weightController),
            _buildTextField('Grupo de Ovo', _eggController),
            
            const Divider(),
            _buildTextField('URL da Imagem', _imageController),
            
            const SizedBox(height: 30),
            ElevatedButton(onPressed: _savePokemon, child: const Text('Salvar Pokémon')),
          ],
        ),
      ),
    );
  }
}