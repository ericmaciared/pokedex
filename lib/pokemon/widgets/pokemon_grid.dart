import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pokemon.dart';
import '../sprite.dart';
import 'pokemon_sprite.dart';
import 'package:pokedex_app/styles.dart';

class PokemonGrid extends StatelessWidget {
  List<Sprite> data;
  int count = 150;
  List<String> owned;
  final VoidCallback onPop;
  bool fromPokedex = false;

  PokemonGrid(
      {super.key,
      required this.data,
      required this.owned,
      required this.onPop}) {
    count = data.length;
  }

  bool isOwned(index) {
    final id = data[index].id;

    return owned.contains("$id");
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return PokemonSprite(
              data: data[index].sprite,
              id: data[index].id,
              owned: isOwned(index),
              onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PokemonPage(
                              id: data[index].id)))
                  // This is to reload the PokemonGrid and check for new captured pokemons
                  .then((value) => {onPop()}));
        });
  }
}
