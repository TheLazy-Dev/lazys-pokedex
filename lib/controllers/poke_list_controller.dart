import 'package:flutter/material.dart';
import 'package:pokedex/models/poke_list_model.dart';
import '../services/poke_list_service.dart';

class PokeListController extends ChangeNotifier {
  PokemonList? pokeList;
  bool isLoading = false;

  getList() async {
    isLoading = true;
    pokeList = await fetchPokeList();
    isLoading = false;

    notifyListeners();
  }
}
