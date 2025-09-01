import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/pokemon_remote_data_source.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/entities/pokemon_detail.dart';

class PokemonDetailProvider extends ChangeNotifier {
  final PokemonRepositoryImpl _repository = PokemonRepositoryImpl(
    remoteDataSource: PokemonRemoteDataSourceImpl(client: http.Client()),
  );

  PokemonDetail? _pokemonDetail;
  PokemonDetail? get pokemonDetail => _pokemonDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemonDetails(String url) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pokemonDetail = await _repository.getPokemonDetails(url);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}