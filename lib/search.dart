import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex_app/graphql.dart';
import 'package:pokedex_app/pokemon.dart';
import 'package:pokedex_app/pokemon/widgets/pokemon_image.dart';
import 'styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<dynamic> searchSuggestions = [];
  late List<String> searchSprites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Styles.mainGray),
          leading: const BackButton()),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.sidePadding),
        Padding(
          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bconst ottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(

            onSubmitted: (search) {
              buildSearchResults(search);
            },
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Search Pokemon',
                hintText: 'Enter Pokemon Name'),
          ),
        ),
        SizedBox(height: Styles.mainPadding),
        //TODO: Check no results and future builder for loading icon
        ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchSuggestions.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 40.0,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PokemonPage(
                              id: searchSuggestions[index]["pokemon_id"]))),
                  title: Text(searchSuggestions[index]["pokemon_v2_pokemon"]
                          ["name"]
                      .toString()
                      .toClean()),
                  leading: PokemonImage(imagePath: searchSprites[index], size: 50),
                  // SizedBox(
                  //   width: 50.0,
                  //   height: 50.0,
                  //   child: ,
                  //       Image.network(searchSprites[index], fit: BoxFit.cover,
                  //           errorBuilder: (context, error, stackTrace) {
                  //     return Image.asset('assets/unown-question.png');
                  //   }),
                  // ),
                ),
              );
            }),
        SizedBox(height: Styles.mainPadding)
      ])),
    );
  }

  buildSearchResults(String search) async {
    final Map<String, dynamic>? searchResultMap =
        await pokedexSpritesStartingWith(search);
    if (searchResultMap != null &&
        searchResultMap.containsKey("pokemon_v2_pokemonsprites")) {
      final List<dynamic> pokemons =
          searchResultMap["pokemon_v2_pokemonsprites"];

      final List<String> sprites = [];
      for (final pokemon in pokemons) {
        final Map<String, dynamic> spritesJson = jsonDecode(pokemon["sprites"]);
        sprites.add(spritesJson["front_default"]);
      }

      setState(() {
        searchSuggestions = pokemons;
        searchSprites = sprites;
      });
    }
  }
}
