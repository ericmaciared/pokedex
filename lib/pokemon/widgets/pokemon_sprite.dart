import 'dart:convert';

import 'package:flutter/material.dart';

// Widget to load an image from url and displays it with a specific size.
class PokemonSprite extends StatelessWidget {
  String? data;
  double size = 30;

  PokemonSprite ({super.key, required this.data, this.size=30});

  String getSprite() {
    final Map<String, dynamic> spritesJson =
    jsonDecode(data!);

    return spritesJson["front_default"];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        child: Image.network(getSprite(), errorBuilder:
            (BuildContext context, Object exception,
            StackTrace? stackTrace) {
          return const Text('ð¢');
        }));
  }
}