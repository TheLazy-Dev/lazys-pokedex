import 'package:pokedex/models/pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<PokemonModel> fetchPokemon(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return PokemonModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load pokemon');
  }
}
