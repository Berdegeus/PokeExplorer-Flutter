import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/pokemon.dart';
import '../../providers/favorite_pokemon_provider.dart';
import '../../providers/pokemon_detail_provider.dart';
import '../atoms/loading_indicator.dart';
import '../atoms/pokemon_type_chip.dart';
import '../atoms/stat_bar.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonDetailProvider()..fetchPokemonDetails(pokemon.url),
      child: Scaffold(
        appBar: AppBar(
          title: Text(pokemon.name[0].toUpperCase() + pokemon.name.substring(1)),
          actions: [
            Consumer<FavoritePokemonProvider>(
              builder: (context, favoritesProvider, _) {
                final bool isFavorite = favoritesProvider.isFavorite(pokemon);
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    favoritesProvider.toggleFavorite(pokemon);
                  },
                );
              },
            ),
          ],
        ),
        body: Consumer<PokemonDetailProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const LoadingIndicator();
            }
            if (provider.errorMessage != null) {
              return Center(child: Text('Error: ${provider.errorMessage}'));
            }
            if (provider.pokemonDetail == null) {
              return const Center(child: Text('Pokémon not found.'));
            }

            final detail = provider.pokemonDetail!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.network(detail.imageUrl, height: 250, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text('Nº ${detail.id}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    alignment: WrapAlignment.center,
                    children: detail.types.map((type) => PokemonTypeChip(type: type)).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Height: ${detail.height / 10} m', style: const TextStyle(fontSize: 18)),
                      Text('Weight: ${detail.weight / 10} kg', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  const Divider(height: 48, thickness: 1),
                  const Text('Abilities', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // Using Chips for abilities for better visuals
                  Wrap(
                    spacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: detail.abilities
                        .map((ability) => Chip(label: Text(ability)))
                        .toList(),
                  ),
                  const Divider(height: 48, thickness: 1),
                  const Text('Base Stats', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...detail.stats.entries.map((entry) {
                    return StatBar(label: entry.key, value: entry.value);
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}