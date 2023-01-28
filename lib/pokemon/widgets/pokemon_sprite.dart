import 'dart:convert';

import 'package:flutter/material.dart';

// Widget to load an image from url and displays it with a specific size.
class PokemonSprite extends StatelessWidget {
  String? data;
  double size = 30;
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
      {super.key, required this.data, required this.owned, this.size = 30});

  String getSprite() {
    final Map<String, dynamic> spritesJson = jsonDecode(data!);
    // TODO: this should be more dynamic so you can get any sprite by passing an argument
    return spritesJson["front_default"];
  }

  SizedBox withColor() {
    return SizedBox(
        height: size,
        child: Image.network(getSprite(), errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text('ERROR');
        }));
  }

  SizedBox withoutColor() {
    return SizedBox(
        height: size,
        child: ColorFiltered(
            colorFilter: greyscale,
            child: Image.network(getSprite(), errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return const Text('ERROR');
            })));
  }

  @override
  Widget build(BuildContext context) {
    return owned ? withColor() : withoutColor();
  }
}
