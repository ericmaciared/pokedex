import 'package:flutter/material.dart';
import 'package:pokedex_app/home.dart';
import 'package:pokedex_app/start.dart';
import 'graphql.dart';

void main() {
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    pokedexSprites();
    return const MaterialApp(
      title: 'Pokédex',
      home: HomePage()
    );
  }
}
