import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon/widgets/pokemon_grid.dart';

import '../../auth.dart';
import '../../firestore_adapter.dart';
import '../../graphql.dart';

class PokemonFutureBuilder extends StatelessWidget {
  const PokemonFutureBuilder({super.key});

  // Function wrapper to get the user' pokemons
  Future<List<String>> getOwnedList() async {
    return await FirestoreAdapter().getPokemons(Auth().currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([pokedexSprites(), getOwnedList()]),
      builder:
          (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return PokemonGrid(
              data: snapshot.data![0], owned: snapshot.data![1]);
        } else {
          return const CircularProgressIndicator(strokeWidth: 4);
        }
      },
    );
  }

}