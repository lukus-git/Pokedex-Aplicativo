import 'package:flutter/material.dart';

class Pokemon {
  final String name; 
  final List<String> type; //aqui vai ser o tipo do pokemon
  final int id; 
  final String num; //numero de cada pokemon na pokedex
  final List<String> weaknesses; // lista de fraquezas
  final String height; 
  final String weight; 
  final String egg;

  //pega o valor de cada chave e tranforma em seu nome, id e etc...
  factory Pokemon.fromMap(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        id: json['id'],
        num: json['num'],
        height: json['height'],
        weight: json['weight'],
        egg: json['egg'],

        //aqui ele mapeia a lista de tipos
        type: (json['type'] as List).map((e) => e as String).toList(),
        // aqui vai mapear a lista de fraquezas
        weaknesses: (json['weaknesses'] as List).map((e) => e as String).toList());
  }

  Color? get baseColor => _color(type: type[0]);

  String get image => 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png';

  Pokemon({
    required this.name,
    required this.id,
    required this.num,
    required this.type,
    required this.weaknesses,
    required this.egg,
    required this.height,
    required this.weight
  });

  static Color? _color({required String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fighting':
        return Colors.orange;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}
