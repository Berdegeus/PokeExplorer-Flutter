import 'dart:convert';
import 'package:http/http.dart' as http; // Corrected line
import '../models/pokemon_model.dart';
import '../models/pokemon_detail_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemonList({int offset = 0, int limit = 20});
  Future<PokemonDetailModel> getPokemonDetails(String url);
  Future<PokemonDetailModel> searchPokemon(String query);

}
class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;
  final String _baseUrl = "https://pokeapi.co/api/v2/pokemon";

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PokemonModel>> getPokemonList({int offset = 0, int limit = 20}) async {
    final response = await client.get(
      Uri.parse('$_baseUrl?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((e) => PokemonModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  @override
  Future<PokemonDetailModel> getPokemonDetails(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return PokemonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }

  @override
  Future<PokemonDetailModel> searchPokemon(String query) async {
    // A API aceita nome ou id, então podemos usar o mesmo endpoint
    final response = await client.get(Uri.parse('$_baseUrl/${query.toLowerCase()}'));

    if (response.statusCode == 200) {
      return PokemonDetailModel.fromJson(json.decode(response.body));
    } else {
      // Lança uma exceção específica para "não encontrado"
      if (response.statusCode == 404) {
        throw Exception('Pokémon não encontrado.');
      }
      throw Exception('Falha ao buscar o Pokémon.');
    }
  }
}