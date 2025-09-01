import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pokemon_provider.dart';
import '../molecules/pokemon_grid_card.dart';

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer widget rebuilds when PokemonProvider notifies listeners
    return Consumer<PokemonProvider>(
      builder: (context, provider, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: provider.pokemons.length,
          itemBuilder: (ctx, i) => PokemonGridCard(
              pokemon: provider.pokemons[i],
              // Remove the onTap property as it's no longer needed
          ),
        );
      },
    );
  }
}