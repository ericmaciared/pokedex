import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon.dart';

// Widget to load an image from url and displays it with a specific size.
class PokemonSprite extends StatelessWidget {
  String? data;
  double size = 30;
  int id;

  PokemonSprite({super.key, required this.data, this.size = 30, required this.id});

  String getSprite() {
    final Map<String, dynamic> spritesJson = jsonDecode(data!);
    return spritesJson["front_default"];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        child: IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => PokemonPage(id: this.id + 1))),
          icon: Image.network(getSprite())
        )
    );
  }
}
