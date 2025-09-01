class Pokemon {
  final String name;
  final String url; // URL to get more details

  Pokemon({required this.name, required this.url});

  // A helper to get the ID from the URL
  String get id => url.split('/')[6];
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}