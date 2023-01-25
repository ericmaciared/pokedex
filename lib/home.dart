import 'package:flutter/material.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'styles.dart';
import 'graphql.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: Styles.mainGray
        ),
        // TODO: change this for proper buttons
        actions: [IconButton(
          icon: Icon(Icons.search, color: Styles.mainGray),
          onPressed: null,
        )]
      ),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.mainPadding),
        Center(child: Styles.H1("PokéDex", Colors.black)),
        SizedBox(height: Styles.mainPadding),
        FutureBuilder<Map<String, dynamic>?>(
          future: pokedexSprites(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.hasData) {
              return PokemonGrid(sprites: snapshot.data);
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
      backgroundColor: Colors.red,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 62,
            // TODO: Add user image and user info
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/189/189001.png'),
          ),
          Styles.H4("Willy", Colors.white),
          Styles.H4("120 pokemon", Colors.white),
        ],
      ),
    );
  }

  Widget buildItems(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(Styles.mainPadding),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Styles.H5("Profile", Colors.white),
              onTap: null,
            ),
            ListTile(
              leading: const Icon(
                Icons.catching_pokemon,
                color: Colors.white,
              ),
              title: Styles.H5("Teams", Colors.white),
              onTap: null,
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              title: Styles.H5("About Us", Colors.white),
              onTap: null,
            )
          ],
        ));
  }
}
