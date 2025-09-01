import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/pokemon.dart';
import '../../providers/pokemon_provider.dart';
import '../atoms/loading_indicator.dart';
import '../organisms/pokemon_grid.dart';
import './favorites_screen.dart';
import './pokemon_detail_screen.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).fetchInitialPokemons();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    // Feedback visual de carregamento
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: LoadingIndicator()),
    );

    final provider = Provider.of<PokemonProvider>(context, listen: false);
    final result = await provider.searchPokemon(query);

    Navigator.pop(context); 

    if (result != null) {
      final pokemon = Pokemon(
        name: result.name,
        url: 'https://pokeapi.co/api/v2/pokemon/${result.id}/',
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PokemonDetailScreen(pokemon: pokemon)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokémon não encontrado!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<PokemonProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.pokemons.isEmpty) {
            return const LoadingIndicator();
          }

          if (provider.listError != null && provider.pokemons.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.listError!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.fetchInitialPokemons,
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }
          
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search Pokémon by name or ID',
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                          ),
                        ),
                        onSubmitted: (_) => _performSearch(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _performSearch,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Find'),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: PokemonGrid(),
              ),
              if (provider.isLoading && provider.pokemons.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: LoadingIndicator(),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<PokemonProvider>(context, listen: false).fetchMorePokemons();
        },
        label: const Text('Carregar Mais'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}