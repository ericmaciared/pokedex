import 'package:flutter/material.dart';

// Widget to load an image from url and displays it with a specific size.
class PokemonSprite extends StatelessWidget {
  String? url;
  double size = 30;

  PokemonSprite ({super.key, required this.url, this.size=30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        child: Image.network(url!, errorBuilder:
            (BuildContext context, Object exception,
            StackTrace? stackTrace) {
          return const Text('ð¢');
        }));
  }
}