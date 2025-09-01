import '../../domain/entities/pokemon_detail.dart';

class PokemonDetailModel extends PokemonDetail {
  PokemonDetailModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    required String imageUrl,
    required List<String> types,
    required List<String> abilities,
    required Map<String, int> stats,
  }) : super(
      id: id,
      name: name,
      height: height,
      weight: weight,
      imageUrl: imageUrl,
      types: types,
      abilities: abilities,
      stats: stats,
    );

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    // Extract types
    final List<String> types = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    // Extract abilities
    final List<String> abilities = (json['abilities'] as List)
        .map((abilityInfo) => abilityInfo['ability']['name'] as String)
        .toList();

    // Extract stats
    final Map<String, int> stats = {
      for (var statInfo in (json['stats'] as List))
        statInfo['stat']['name']: statInfo['base_stat']
    };

    return PokemonDetailModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: types,
      abilities: abilities,
      stats: stats,
    );
  }
}