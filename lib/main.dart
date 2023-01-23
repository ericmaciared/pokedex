import 'package:flutter/material.dart';
import 'graphql.dart';
import 'home.dart';
import 'login.dart';


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
      home: LoginPage(),
    );
  }
}
