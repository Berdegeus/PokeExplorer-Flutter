import 'package:flutter/material.dart';
import '../../../domain/entities/pokemon.dart';
import '../pages/pokemon_detail_screen.dart'; // Import the detail screen

class PokemonGridCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonGridCard({super.key, required this.pokemon});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Use Navigator to push the new screen onto the stack
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetailScreen(pokemon: pokemon),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon.imageUrl,
              height: 84,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 8),
            Text(
              pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}