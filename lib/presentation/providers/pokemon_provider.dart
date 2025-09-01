import 'package:flutter/material.dart';
import '../../data/datasources/pokemon_remote_data_source.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import 'package:http/http.dart' as http;

class PokemonProvider extends ChangeNotifier {
  final PokemonRepositoryImpl _repository = PokemonRepositoryImpl(
    remoteDataSource: PokemonRemoteDataSourceImpl(client: http.Client()),
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Pokemon> _pokemons = [];
  List<Pokemon> get pokemons => _pokemons;
  
  int _offset = 0;

  String? _listError;
  String? get listError => _listError;

  Future<void> fetchInitialPokemons() async {
    _isLoading = true;
    _listError = null; 
    notifyListeners();
    
    try {
      final newPokemons = await _repository.getPokemonList(offset: 0);
      _pokemons = newPokemons; 
      _offset = 20;
    } catch(e) {
      _listError = 'Falha ao carregar Pokémon. Tente novamente.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMorePokemons() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    
    try {
      final newPokemons = await _repository.getPokemonList(offset: _offset);
      _pokemons.addAll(newPokemons);
      _offset += 20;
    } catch(e) {
      // Aqui poderíamos usar um SnackBar, mas por enquanto só printamos
      print("Erro ao carregar mais: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<PokemonDetail?> searchPokemon(String query) async {
    try {
      final pokemonDetail = await _repository.searchPokemon(query);
      return pokemonDetail;
    } catch (e) {
      print("Erro na busca: $e");
      return null;
    }
  }
}