import 'package:flutter/material.dart';
import 'package:pokedex_app/home.dart';
import 'graphql.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
