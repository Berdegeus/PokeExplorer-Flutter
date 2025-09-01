import 'package:flutter/material.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;
  const PokemonTypeChip({super.key, required this.type});

  // Simple map to get colors for types
  static const Map<String, Color> _typeColorMap = {
    'fire': Colors.red, 'water': Colors.blue, 'grass': Colors.green,
    'electric': Colors.amber, 'psychic': Colors.purple, 'ice': Colors.lightBlue,
    'dragon': Colors.indigo, 'dark': Colors.brown, 'fairy': Colors.pinkAccent,
    'normal': Colors.grey, 'fighting': Colors.deepOrange, 'flying': Colors.cyan,
    'poison': Colors.deepPurple, 'ground': Colors.orange, 'rock': Colors.brown,
    'bug': Colors.lightGreen, 'ghost': Colors.purpleAccent, 'steel': Colors.blueGrey,
  };

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: _typeColorMap[type.toLowerCase()] ?? Colors.grey,
      label: Text(
        type.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}