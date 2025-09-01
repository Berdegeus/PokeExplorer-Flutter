import 'package:poke_explorer/domain/entities/pokemon_detail.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Pokemon>> getPokemonList({int offset = 0, int limit = 20}) async {
    try {
      final pokemonModels = await remoteDataSource.getPokemonList(offset: offset, limit: limit);
      // The repository's job is to convert data models to domain entities if needed.
      // In this case, PokemonModel is a direct subclass of Pokemon, so we can return it.
      return pokemonModels;
    } catch (e) {
      // Here you would handle errors, maybe return a Failure object
      throw Exception('Error fetching data: $e');
    }
  }
  
  Future<PokemonDetail> getPokemonDetails(String url) async {
    try {
      return await remoteDataSource.getPokemonDetails(url);
    } catch (e) {
      throw Exception('Error fetching details: $e');
    }
  }

  @override
  Future<PokemonDetail> searchPokemon(String query) async {
    try {
      return await remoteDataSource.searchPokemon(query);
    } catch (e) {
      // Propaga a exceção para a camada de apresentação tratar
      rethrow;
    }
  }
}