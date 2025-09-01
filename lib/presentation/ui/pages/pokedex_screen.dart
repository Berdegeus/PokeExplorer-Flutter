import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pokemon_provider.dart';
import '../atoms/loading_indicator.dart';
import '../organisms/pokemon_grid.dart';
import './favorites_screen.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to fetch data after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).fetchInitialPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: pokemonProvider.pokemons.isEmpty && pokemonProvider.isLoading
                ? const LoadingIndicator()
                : const PokemonGrid(),
          ),
          if (pokemonProvider.isLoading && pokemonProvider.pokemons.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LoadingIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pokemonProvider.fetchMorePokemons();
        },
        label: const Text('Carregar Mais'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}