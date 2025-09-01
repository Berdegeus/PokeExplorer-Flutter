import 'package:poke_explorer/domain/entities/pokemon_detail.dart';
import 'package:poke_explorer/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({int offset = 0, int limit = 20});
  Future<PokemonDetail> getPokemonDetails(String url);
  Future<PokemonDetail> searchPokemon(String query);
}