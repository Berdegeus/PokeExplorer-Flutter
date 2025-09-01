import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({required String name, required String url})
      : super(name: name, url: url);

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      url: json['url'],
    );
  }
}