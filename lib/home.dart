import 'package:flutter/material.dart';
import 'package:pokedex_app/auth.dart';
import 'package:pokedex_app/firestore_adapter.dart';
import 'package:pokedex_app/login.dart';
import 'package:pokedex_app/pokemon/generations/generation_manager.dart';
import 'package:pokedex_app/pokemon/generations/range.dart';
import 'package:pokedex_app/pokemon/sprite.dart';
import 'package:pokedex_app/pokemon/widgets/pokemon_grid.dart';
import 'package:pokedex_app/search.dart';
import 'styles.dart';
import 'graphql.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      generation = generationManager.gen;
    });
  }

  // Function wrapper to get the user' pokemons
  Future<List<String>> getOwnedList() async {
    return await FirestoreAdapter().getPokemons(Auth().currentUser!);
  }

  GenerationManager generationManager = GenerationManager.init();
  late Range generation = generationManager.gen;

  void nextGen() {
    generationManager.next();
    setState(() {
      generation = generationManager.gen;
    });
  }

  void prevGen() {
    generationManager.prev();
    setState(() {
      generation = generationManager.gen;
    });
  }

  Future<List<Sprite>> getSprites() async {
    List<Sprite> sprites = [];
    Map<String, dynamic>? data =
        await pokedexSpritesInRange(generation.low, generation.high);

    for (var pokemon in data!["pokemon_v2_pokemonsprites"]) {
      sprites.add(Sprite(id: pokemon["id"], sprite: pokemon["sprites"]));
    }

    return sprites;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Styles.mainGray),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Styles.mainGray),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchPage())),
            )
          ]),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.mainPadding),
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              IconButton(
                  onPressed: prevGen, icon: const Icon(Icons.arrow_back)),
              Column(
                  children: <Widget> [
                    Styles.H1("PokéDex", Colors.black),
                    Styles.H5("Gen ${generationManager.id}", Colors.black)
                  ]),
              IconButton(
                  onPressed: nextGen, icon: const Icon(Icons.arrow_forward))
            ])),
        SizedBox(height: Styles.mainPadding),
        FutureBuilder(
          future: Future.wait([getSprites(), getOwnedList()]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return PokemonGrid(
                data: snapshot.data![0],
                owned: snapshot.data![1],
                onPop: () => {setState(() {})},
              );
            } else {
              return const CircularProgressIndicator(strokeWidth: 4);
            }
          },
        )
      ])),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: Colors.red,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildHeader(context),
            buildItems(context),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginPage())),
              child: Styles.H4("Logout >", Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + Styles.mainPadding),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 62,
            // TODO: Add user image and user info
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/189/189001.png'),
          ),
          SizedBox(height: Styles.sidePadding),
          Styles.H4("Willy", Colors.white),
          Styles.H4("120 pokemon", Colors.white),
        ],
      ),
    );
  }

  Widget buildItems(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(Styles.sidePadding),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: Styles.sidePadding,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Styles.H4("Profile", Colors.white),
              onTap: null,
            ),
            ListTile(
              leading: const Icon(
                Icons.catching_pokemon,
                color: Colors.white,
              ),
              title: Styles.H4("Teams", Colors.white),
              onTap: null,
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              title: Styles.H4("About Us", Colors.white),
              onTap: null,
            )
          ],
        ));
  }
}
