import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/pokemon/api_adapter.dart';
import 'styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<PokemonDO> searchSuggestions = [];

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
              searchSuggestions = buildSearchResults(search);
            });
          },
        ),
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: searchSuggestions.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Entry')),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        )),
        SizedBox(height: Styles.mainPadding)
      ])),
    );
  }

  buildSearchResults(String search) {}
}
