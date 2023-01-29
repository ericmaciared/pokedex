import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon.dart';

// Widget to load an image from url and displays it with a specific size.
class PokemonSprite extends StatelessWidget {
  String? data;
  double size = 30;
  int id;
  bool owned;

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
      required this.id});

  String getSprite() {
    final Map<String, dynamic> spritesJson = jsonDecode(data!);
    return spritesJson["front_default"];
  }

  Image withColor() {
    return Image.network(getSprite());
  }

  ColorFiltered withoutColor() {
    return ColorFiltered(
        colorFilter: greyscale,
        child: Image.network(getSprite())
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        child: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => PokemonPage(id: id + 1))),
            icon: owned ? withColor() : withoutColor()));
  }
}
