import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/common/consts/api_const.dart';
import 'package:pokedex/common/error/failure.dart';
import 'package:pokedex/common/models/pokemon.dart';

abstract class IPokemonRepository {
  Future<List<Pokemon>> getAllPokemons();
}

class PokemonRepository implements IPokemonRepository {
  final Dio dio;

  PokemonRepository({required this.dio});
  @override
  Future<List<Pokemon>> getAllPokemons() async {
    try {
      //aqui vai na net e pega os dados
      final response = await dio.get(ApiConsts.allPokemonsURL);

      //pega o texto estranho (JSON) e transforma em um dicionário (Map)
      final json = jsonDecode(response.data) as Map<String, dynamic>;

      //dentro do dicionário pega só a lista que está na chave 'pokemon'
      final list = json['pokemon'] as List<dynamic>;

      //pega cada item da lista e transforma ele em um objeto Pokemon real e Depois retorna a lista final
      return list.map((e) => Pokemon.fromMap(e)).toList();
    } catch (e) {
      //aqui é se caso a net cair ou algum outro erro
      throw Failure(message: 'não foi possivel carregar');
    }
  }
}
