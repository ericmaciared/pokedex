import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/graphql.dart';
import 'package:pokedex_app/pokemon/api_adapter.dart';
import 'styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<dynamic> searchSuggestions = [];

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
        SizedBox(height: Styles.mainPadding),
        TextField(
          onChanged: (search) {
            setState(() {
              buildSearchResults(search);
            });
          },
        ),
        SizedBox(height: Styles.mainPadding),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchSuggestions.length,
            itemBuilder: (BuildContext context, int index) {
              return Text("Here goes a pokemon. ${searchSuggestions.length}");
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
          searchResultMap!["pokemon_v2_pokemonsprites"];
      searchSuggestions = pokemons;
    }
  }
}