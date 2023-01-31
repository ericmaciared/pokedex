import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon.dart';

// Widget to load an image from url and displays it with a specific size.
class PokemonSprite extends StatelessWidget {
  String? data;
  double size = 30;
  int? id;
  bool? owned;
  final VoidCallback onPress;
  final spritesUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master";
  late String sprite;

  // Greyscale color matrix. Obtained from the official docs:
  // https://api.flutter.dev/flutter/dart-ui/ColorFilter/ColorFilter.matrix.html
  final ColorFilter greyscale = const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  PokemonSprite(
      {super.key,
      required this.data,
      required this.owned,
      this.size = 30,
      required this.id,
      required this.onPress}) {
    sprite = getSprite();
  }

  String getSprite() {
    final Map<String, dynamic> spritesJson = jsonDecode(data!);
    return appendUrl(spritesJson["front_default"]);
  }

  String appendUrl(String sprite) {
    final String url = sprite.replaceFirst("/media", spritesUrl);
    return url;
  }

  Image withColor(String imageUrl) {
    return Image.network(imageUrl);
  }

  ColorFiltered withoutColor(String imageUrl) {
    return ColorFiltered(
        colorFilter: greyscale, child: Image.network(imageUrl));
  }

  PokemonSprite.fromSprite(
      {super.key, required String sprite, required this.onPress, this.size=30}) {
    this.sprite = appendUrl(sprite);
    // TODO: Should we show owned pokemons in the evolutions section as well?
    owned = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        child: IconButton(
            onPressed: onPress,
            icon: owned! ? withColor(sprite) : withoutColor(sprite)));
  }
}
