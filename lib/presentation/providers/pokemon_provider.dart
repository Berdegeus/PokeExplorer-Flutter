import 'package:flutter/material.dart';
import '../../data/datasources/pokemon_remote_data_source.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/entities/pokemon.dart';
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

  Future<void> fetchInitialPokemons() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newPokemons = await _repository.getPokemonList(offset: _offset);
      _pokemons.addAll(newPokemons);
      _offset += 20;
    } catch(e) {
      // Handle error state
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMorePokemons() async {
     if (_isLoading) return; // Prevent multiple calls
    _isLoading = true;
    notifyListeners();

     try {
      final newPokemons = await _repository.getPokemonList(offset: _offset);
      _pokemons.addAll(newPokemons);
      _offset += 20;
    } catch(e) {
       print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}