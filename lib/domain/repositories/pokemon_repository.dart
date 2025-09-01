import '../entities/pokemon.dart';

// This is an abstract class that acts as a contract for our data layer.
abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({int offset = 0, int limit = 20});
  // We will add more methods here later for details and search.
}