import 'package:flutter/material.dart';
import 'package:pokedex_app/about_us.dart';
import 'package:pokedex_app/auth.dart';
import 'package:pokedex_app/firestore/firestore_adapter.dart';
import 'package:pokedex_app/login.dart';
import 'package:pokedex_app/pokemon/generations/generation_manager.dart';
import 'package:pokedex_app/pokemon/generations/range.dart';
import 'package:pokedex_app/pokemon/sprite.dart';
import 'package:pokedex_app/pokemon/widgets/pokemon_grid.dart';
import 'package:pokedex_app/profile.dart';
import 'package:pokedex_app/search.dart';
import 'firestore/user_data.dart';
import 'styles.dart';
import 'graphql.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GenerationManager generationManager = GenerationManager.init();
  late Range generation = generationManager.gen;
  UserData user = UserData("Loading...", "Loading...");

  @override
  void initState() {
    super.initState();
    initHomePage();
  }

  Future<void> initHomePage() async {
    FirestoreAdapter().getUserData(Auth().currentUser!).then((value) {
      setState(() {
        generation = generationManager.gen;
        user = value!;
      });
    });
  }

  Future<int> getNumCapturedPokemons() async {
    List<String> captured =
        await FirestoreAdapter().getPokemons(Auth().currentUser!);

    return captured.length;
  }

  // Function wrapper to get the user' pokemons
  Future<List<String>> getOwnedList() async {
    return await FirestoreAdapter().getPokemons(Auth().currentUser!);
  }

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
      drawer: FutureBuilder<int>(
          future: getNumCapturedPokemons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return NavigationDrawer(
                  user: user,
                  numPokemons: snapshot.data!,
                  refresh: () => initHomePage());
            } else {
              return NavigationDrawer(
                  user: user, numPokemons: 0, refresh: () => setState(() {}));
            }
          }),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.mainPadding),
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              IconButton(
                  onPressed: prevGen, icon: const Icon(Icons.arrow_back)),
              Column(children: <Widget>[
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
  final UserData user;
  final VoidCallback refresh;
  final int numPokemons;

  NavigationDrawer(
      {super.key,
      required this.user,
      required this.numPokemons,
      required this.refresh});

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
          Styles.H4(user.name, Colors.white),
          Styles.H4("$numPokemons pokemon", Colors.white),
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
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfilePage(
                            numPokemons: numPokemons,
                          ))).then((value) => refresh()),
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              title: Styles.H4("About Us", Colors.white),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AboutUsPage()))
            ),
          ],
        ));
  }
}
