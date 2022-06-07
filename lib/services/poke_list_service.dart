import 'package:pokedex/models/poke_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<PokemonList> fetchPokeList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000'));

  if (response.statusCode == 200) {
    return PokemonList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load pokeList');
  }
}
