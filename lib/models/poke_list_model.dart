// To parse this JSON data, do
//
//     final pokemonList = pokemonListFromJson(jsonString);

import 'dart:convert';

class PokemonList {
  PokemonList({
    required this.pokeList,
  });

  List<PokeList> pokeList;

  factory PokemonList.fromRawJson(String str) =>
      PokemonList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokemonList.fromJson(Map<String, dynamic> json) => PokemonList(
        pokeList: List<PokeList>.from(
            json["results"].map((x) => PokeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(pokeList.map((x) => x.toJson())),
      };
}

class PokeList {
  PokeList({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory PokeList.fromRawJson(String str) =>
      PokeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokeList.fromJson(Map<String, dynamic> json) => PokeList(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
