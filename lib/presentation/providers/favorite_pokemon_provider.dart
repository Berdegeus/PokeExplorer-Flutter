import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';

class FavoritePokemonProvider extends ChangeNotifier {
  final List<Pokemon> _favorites = [];

  // Public getter to access the list of favorites
  List<Pokemon> get favorites => _favorites;

  // Helper method to check if a Pokémon is already a favorite
  bool isFavorite(Pokemon pokemon) {
    // We check by name since the objects might be different instances
    return _favorites.any((fav) => fav.name == pokemon.name);
  }

  // Method to add or remove a Pokémon from the favorites list
  void toggleFavorite(Pokemon pokemon) {
    if (isFavorite(pokemon)) {
      _favorites.removeWhere((fav) => fav.name == pokemon.name);
    } else {
      _favorites.add(pokemon);
    }
    // Notify all listening widgets that the state has changed
    notifyListeners();
  }
}