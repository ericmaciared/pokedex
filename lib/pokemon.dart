import 'package:flutter/material.dart';
import 'package:pokedex/login.dart';
import 'package:pokedex/pokemon/widgets/pokemon_future_builder.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'styles.dart';
import 'graphql.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key, required this.id});

  final int id;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Styles.H3('Nº150', Styles.mainGray),
          centerTitle: true,
          iconTheme: IconThemeData(color: Styles.mainGray),
          leading: const BackButton(),
          actions: const [
            IconButton(
              icon: Icon(Icons.catching_pokemon, color: Colors.red),
              //TODO
              onPressed: null,
            )
          ]),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.mainPadding),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
            child: Center(
              child: Container(
                  height: 350,
                  padding: EdgeInsets.all(Styles.mainPadding),
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('assets/150.png')),
            )),
        SizedBox(height: Styles.mainPadding),
        Styles.H1('Mewtwo', Colors.black),
        Styles.H4('Genetic Pokemon', Colors.black),
        typeImage('Psychic'),
        const PokemonFutureBuilder()
      ])),
    );
  }

  Widget typeImage(String type) {
    return Row(
      children: [
        Image.asset('assets/types/$type.png')
      ],
    );
  }
}
