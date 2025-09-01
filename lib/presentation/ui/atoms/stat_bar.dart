import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;

  const StatBar({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = 255, // A common max stat value in Pokémon games
  });

  // Helper to format stat labels nicely (e.g., "special-attack" -> "Special Attack")
  String get formattedLabel {
    return label
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  // Color changes based on the stat value
  Color get statColor {
    if (value < 50) return Colors.red;
    if (value < 90) return Colors.amber;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              formattedLabel,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: LinearProgressIndicator(
              value: value / maxValue,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(statColor),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}