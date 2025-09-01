import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/favorite_pokemon_provider.dart';
import 'presentation/providers/pokemon_provider.dart';
import 'presentation/ui/pages/pokedex_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MultiProvider to register all app-wide providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
        ChangeNotifierProvider(create: (_) => FavoritePokemonProvider()),
      ],
      child: MaterialApp(
        title: 'Poke Explorer',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PokedexScreen(),
      ),
    );
  }
}