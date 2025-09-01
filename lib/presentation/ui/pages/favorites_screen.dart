import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorite_pokemon_provider.dart';
import '../molecules/pokemon_grid_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      // Use a Consumer to listen for changes to the favorites list
      body: Consumer<FavoritePokemonProvider>(
        builder: (context, provider, _) {
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não tem Pokémon favoritos.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Reuse the same GridView layout
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: provider.favorites.length,
            itemBuilder: (ctx, i) => PokemonGridCard(
              pokemon: provider.favorites[i],
            ),
          );
        },
      ),
    );
  }
}