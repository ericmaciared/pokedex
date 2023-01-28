import 'package:flutter/cupertino.dart';
import 'pokemon_sprite.dart';
import 'package:pokedex_app/styles.dart';

class PokemonGrid extends StatelessWidget {
  Map<String, dynamic>? sprites;
  int count = 150;

  PokemonGrid({super.key, required this.sprites, this.count=150});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5),
        padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return PokemonSprite(data: sprites!["pokemon_v2_pokemonsprites"][index]["sprites"], id: index);
        });
  }
}