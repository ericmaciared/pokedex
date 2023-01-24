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
        backgroundColor: Colors.red,
        // TODO: change this for proper buttons
        leading: const BackButton(),
        actions: const [BackButton()],
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
