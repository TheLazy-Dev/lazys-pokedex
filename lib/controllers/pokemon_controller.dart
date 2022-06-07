import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';

import '../services/pokemon_service.dart';

class PokemonController extends ChangeNotifier {
  PokemonModel? pokemon;
  bool isLoading = false;

  getPokemon(String url) async {
    isLoading = true;
    pokemon = await fetchPokemon(url);
    isLoading = false;

    notifyListeners();
  }
}
